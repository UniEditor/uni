package editor.extention ;
import editor.event.EventManager;
import haxe.ds.Vector;
import haxe.ui.toolkit.core.xml.XMLProcessor;
import hscript.Expr;
import openfl.events.Event;
import openfl.net.URLRequest;
import script.ScriptManager;
import sys.FileSystem;
import sys.io.File;
import utils.Utils;

/**
 * ...
 * @author GDB
 */
class ExtManager
{
	
	//singleton
	public static var instance:ExtManager;
	public static function getIns():ExtManager {
		if (instance == null) {
			instance = new ExtManager();
		}
		return instance;
	}
	
	public function new() 
	{
		mapExt = new Map<String, Extension>();
		mapPanelInfo = new Map<String, PanelInfo>();
		mapCmdInfo= new Map<String, CmdInfo>();
		
		cmdList = new Array<String>();
		panelList = new Array<String>();
		exporterList = new Array<String>();
	}
	
	//data
	public var mapExt:Map<String, Extension>;
	public var mapPanelInfo:Map<String, PanelInfo>;
	public var mapCmdInfo:Map<String, CmdInfo>;
	
	//for menu
	public var cmdList:Array<String>;//things to put in command folder
	public var exporterList:Array<String>;//things to put in exportList folder
	public var panelList:Array<String>;//things to put in panel folder
	
	public function loadExts():Void {
		
		//recursively find in res folder
		var basePath = "./res";
		trace("---load ext and xml---");
		loadExtFromFolder(basePath);
		
		//bind ext and panel together
		trace("---bind---");
		bindPanelAndExt();
		
		//call init on all exts
		trace("---init---");
		initExts();
		
		//after init
		EventManager.getIns().dispatchEvent(new Event(EventManager.EXT_AFTER_INIT));
	}
	
	public function loadExtFromFolder(fullPath:String) {
		var res:Array<String> = FileSystem.readDirectory(fullPath);
		if (res == null) { return;	}
		
		for (s in res) {
			var childItemPath:String = fullPath + "/" + s;
			var isFolder:Bool = FileSystem.isDirectory(childItemPath); 
			
			if (isFolder == true) {
				loadExtFromFolder(childItemPath);
			}else {
				var endFix:String = Utils.getEndfix(s);
				if (endFix == "hs" || endFix == "hx") {
					trace("Doing HS: " + childItemPath);
					var id:String = parseExtFromFile(childItemPath, fullPath);
				}else if (endFix == "xml") {
					trace("Doing XML: " + childItemPath);
					parseXmlFromFile(childItemPath);
				}
			}
		}
	}
	
	public function parseExtFromFile(childItemPath:String, folderPath:String):String {
		var content:String = File.getContent(childItemPath);
		
		var theExt:Extension = new Extension();
		theExt.fullPath = childItemPath;
		theExt.folderPath = folderPath;
		theExt.id = childItemPath;//todo replace "/" to "."
		
		ScriptManager.getIns().runString(content,theExt.interp);
		mapExt[theExt.id] = theExt;
		
		return theExt.id;
	}
	
	public function parseXmlFromFile(childItemPath:String):Void {
		var content:String = File.getContent(childItemPath);
		//trace("content:" + content);
		
		var xml:Xml = Xml.parse(content);
		
		var defineXml:Xml = getFirstNamedElement(xml, "panelDefine");
		if (defineXml != null) {
			
			var isUnderExporter:Bool = Utils.isUnderPath(childItemPath, "./res/ext/exporters/");
			var isUnderPanel:Bool = Utils.isUnderPath(childItemPath, "./res/ext/panels/");
			
			if (isUnderPanel) {
				parsePanelFromXml(defineXml, childItemPath, false); 
			}else if (isUnderExporter) {
				parsePanelFromXml(defineXml, childItemPath, true); 
			}
			return;
		}
		
		defineXml = getFirstNamedElement(xml, "cmdDefine");
		if(defineXml != null){
			parseCommandFromXml(defineXml, childItemPath, true);
			return;
		}
		
		trace("This xml is out of valid paths: " + childItemPath);
	}
	
	public function parsePanelFromXml(panelDefine:Xml, childItemPath:String, isExporter:Bool ):Void {

		var frameXml:Xml = null;
		var bodyXml:Xml = null;

		if(panelDefine != null){
			for (one in panelDefine.elementsNamed("frame") ) {
				frameXml = one; break;
			}
			for (one in panelDefine.elementsNamed("body") ) {
				bodyXml = one; break;
			}
		}
		
		if (panelDefine != null && frameXml != null) {
			var id:String = panelDefine.get("id");
			var title:String = panelDefine.get("title");
			
			if (panelDefine.exists("id") == false) {
				trace("ERROR no id from " + childItemPath);
				return;
			}
			
			if (panelDefine.exists("title") == false) {
				trace("ERROR no id title " + childItemPath);
				return;
			}
			
			if(mapPanelInfo.exists(id)){
				trace("ERROR panel id already exist " + id);
				return;
			}
			
			var panelInfo:PanelInfo = new PanelInfo();
			panelInfo.id = id;
			panelInfo.title = title;
			panelInfo.body = bodyXml;
			panelInfo.extId = panelDefine.get("extId");
			panelInfo.resizable = frameXml.get("resize") == "true";
			panelInfo.defaultWd = Std.parseInt(frameXml.get("defaultWd"));
			panelInfo.defaultHt = Std.parseInt(frameXml.get("defaultHt"));
			panelInfo.defaultX = Std.parseInt(frameXml.get("defaultX"));
			panelInfo.defaultY = Std.parseInt(frameXml.get("defaultY"));
			
			
			panelInfo.isExporter = isExporter;
			
			
			if(isExporter == false){
				panelList.push(id);
			}else {
				exporterList.push(id);
			}
			mapPanelInfo.set(id, panelInfo);
		}
		
	}
	
	
	public function parseCommandFromXml(cmdDefine:Xml, childItemPath:String, isExporter:Bool ):Void {
	
		if (cmdDefine != null) {
			var id:String = cmdDefine.get("id");
			var title:String = cmdDefine.get("title");
			
			if (cmdDefine.exists("id") == false) {
				trace("ERROR no id from " + childItemPath);
				return;
			}
			
			if (cmdDefine.exists("title") == false) {
				trace("ERROR no id title " + childItemPath);
				return;
			}
			
			if(mapCmdInfo.exists(id)){
				trace("ERROR cmd id already exist " + id);
				return;
			}
			
			var cmdInfo:CmdInfo = new CmdInfo();
			cmdInfo.id = id;
			cmdInfo.title = title;
			cmdInfo.extId = cmdDefine.get("extId");
			
			cmdList.push(id);
			mapCmdInfo.set(id, cmdInfo);
		}
		
	}
	
	
	public function bindPanelAndExt():Void {
		trace("bindPanelAndExt");
		
		//loop panels and bind exts
		for (one in mapPanelInfo) {
			if (one.extId != null && one.extId != "" && mapExt.exists(one.extId)) {
				mapExt[one.extId].panelId = one.id;
			}
		}
	}
	
	public function initExts():Void {
		try{
			for (one in mapExt) {
				if (one.onInit != null) {
					one.onInit();
				}
			}
		}catch (e:Error) {
			trace("SCRIPT ERROR: " + e.e);
		}
	}
	
	public function updateExts():Void {
		
	}
	
	//tool functions
	
	
	
	public function getFirstNamedElement(xml:Xml, name:String):Xml {
		for (one in xml.elementsNamed(name) ) {
			return one;
		}
		return null;
	}
}

class PanelInfo {
	
	public var id:String;
	public var title:String;
	public var body:Xml;
	public var extId:String;
	
	public var resizable:Bool;
	public var minWd:Int;
	public var minHt:Int;
	public var defaultWd:Int;
	public var defaultHt:Int;
	
	//todo have a better way to deal with default pos of panels
	public var defaultX:Int;
	public var defaultY:Int;
	
	public var isExporter:Bool;
	
	public function new(){
	}
}

class CmdInfo {
	
	public var id:String;
	public var title:String;
	public var extId:String;
	
	public function new(){
	}
}