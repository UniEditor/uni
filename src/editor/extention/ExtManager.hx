package editor.extention ;
import editor.event.EventManager;
import haxe.ds.Vector;
import haxe.ui.toolkit.core.xml.XMLProcessor;
import openfl.events.Event;
import openfl.net.URLRequest;
import script.ScriptManager;
import sys.FileSystem;
import sys.io.File;

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
		mapExporterInfo = new Map<String, ExporterInfo>();
		
		commandList = new Array<String>();
		panelList = new Array<String>();
		exporterList = new Array<String>();
	}
	
	//data
	public var mapExt:Map<String, Extension>;
	public var mapPanelInfo:Map<String, PanelInfo>;
	public var mapExporterInfo:Map<String, ExporterInfo>;
	
	
	//for menu
	public var commandList:Array<String>;//things to put in command folder
	public var exporterList:Array<String>;//things to put in exportList folder
	public var panelList:Array<String>;//things to put in panel folder
	
	public function loadExts():Void {
		
		//recursively find in res folder
		var basePath = "./res/";
		loadExtFromFolder(basePath);
		
		//bind ext and panel together
		bindPanelAndExt();
		
		//call init on all exts
		initExts();
		
		//after init
		EventManager.getIns().dispatchEvent(new Event(EventManager.EXT_AFTER_INIT));
	}
	
	public function loadExtFromFolder(fullPath:String) {
		
		var res:Array<String> = FileSystem.readDirectory(fullPath);
		if (res == null) {
			return;	
		}
		for (s in res) {
			var childItemPath:String = fullPath + "/" + s;
			var isFolder:Bool = FileSystem.isDirectory(childItemPath); 
			
			if (isFolder == true) {
				loadExtFromFolder(childItemPath);
			}else {
				var endFix:String = getEndfix(s);
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
		trace("EXT.ID", theExt.id);
		//id usually be set during the first run
		mapExt[theExt.id] = theExt;
		
		return theExt.id;
	}
	
	
	public function parseXmlFromFile(childItemPath:String):Void {
		
		var content:String = File.getContent(childItemPath);
		//trace("content:" + content);
		
		var xml:Xml = Xml.parse(content);
		
		var defineXml:Xml = getFirstNamedElement(xml, "panelDefine");
		if(defineXml != null){
			parsePanelFromXml(defineXml, childItemPath);
			return;
		}
		
		defineXml = getFirstNamedElement(xml, "exporterDefine");
		if(defineXml != null){
			parseExporterFromXml(defineXml, childItemPath);
			return;
		}
	}
	
	public function parsePanelFromXml(panelDefine:Xml, childItemPath:String):Void {

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
			}
			
			if (panelDefine.exists("title") == false) {
				trace("ERROR no id title " + childItemPath);
			}
			
			var panelInfo:PanelInfo = new PanelInfo();
			panelInfo.id = id;
			panelInfo.title = title;
			panelInfo.body = bodyXml;
			panelInfo.extId = panelDefine.get("extId");
			
			
			//todo check same id problem
			
			mapPanelInfo.set(id, panelInfo);
			panelList.push(id);
		}
		
	}
	
	public function parseExporterFromXml(xmlDefine:Xml, childItemPath:String):Void {
		
		var frameXml:Xml = null;
		var bodyXml:Xml = null;

		if(xmlDefine != null){
			for (one in xmlDefine.elementsNamed("frame") ) {
				frameXml = one; break;
			}
			for (one in xmlDefine.elementsNamed("body") ) {
				bodyXml = one; break;
			}
		}
		
		if (xmlDefine != null && frameXml != null) {
			var id:String = xmlDefine.get("id");
			var title:String = xmlDefine.get("title");
			
			if (xmlDefine.exists("id") == false) {
				trace("ERROR no id from " + childItemPath);
			}
			
			if (xmlDefine.exists("title") == false) {
				trace("ERROR no id title " + childItemPath);
			}
			
			var expInfo:ExporterInfo = new ExporterInfo();
			expInfo.id = id;
			expInfo.title = title;
			expInfo.body = bodyXml;
			expInfo.extId = xmlDefine.get("extId");
			
			
			//todo check same id problem

			mapExporterInfo.set(id, panelInfo);
			exporterList.push(id);
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
		for (one in mapExt) {
			if (one.onInit != null) {
				one.onInit();
			}
		}
	}
	
	public function updateExts():Void {
		
	}
	
	//tool functions
	
	public function getEndfix(path:String):String {
		//trace("getEndfix 1 " + path);
		var lastDot:Int = path.lastIndexOf(".");
		if(lastDot >= 0){
			var endFix:String = path.substr(lastDot + 1);
			return endFix;
		}
		return "";
	}
	
	public function getFirstNamedElement(xml:Xml, name:String):Void {
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
	
	public function new(){
	}
}

class ExporterInfo {
	
	public var id:String;
	public var title:String;
	public var body:Xml;
	public var extId:String;
	
	public var width:Int;
	public var height:Int;
	
	public function new(){
	}
}