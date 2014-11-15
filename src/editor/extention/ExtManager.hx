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
		
		commandList = new Array<String>();
		panelList = new Array<String>();
		exporterList = new Array<String>();
	}
	
	//data
	public var mapExt:Map<String, Extension>;
	public var mapPanelInfo:Map<String, PanelInfo>;
	
	//for menu
	public var commandList:Array<String>;//things to put in command folder
	public var exporterList:Array<String>;//things to put in exportList folder
	public var panelList:Array<String>;//things to put in panel folder
	
	public function loadExts():Void {
		//recursively find in res folder
		var basePath = "./res/";
		loadExtFromFolder(basePath);
		
		//after init
		EventManager.getIns().dispatchEvent(new Event(EventManager.EXT_AFTER_INIT));
	}
	
	public function loadExtFromFolder(fullPath:String) {
		
		var res:Array<String> = FileSystem.readDirectory(fullPath);
		if (res != null) {
			for (s in res) {
				var childItemPath:String = fullPath + "/" + s;
				var isFolder:Bool = FileSystem.isDirectory(childItemPath); 
				
				if (isFolder == true) {
					loadExtFromFolder(childItemPath);
				}else {
					if (getEndfix(s) == "hs") {
						trace("got hs file: " + childItemPath);

						var content:String = File.getContent(childItemPath);
						//trace("content:" + content);
						
						
						//bind ext
						var theExt:Extension = new Extension();
						theExt.fullPath = childItemPath;
						mapExt[childItemPath] = theExt;
						
						ScriptManager.getIns().interp.variables.set("this", theExt);
						ScriptManager.getIns().runString(content);
						
					}else if (getEndfix(s) == "xml") {
						trace("got xml file: " + childItemPath);
						
						var content:String = File.getContent(childItemPath);
						trace("content:" + content);
						
						var xml:Xml = Xml.parse(content);
						
						var defineXml:Xml = null;
						var foundDefine = false;
						for (one in xml.elementsNamed("panelDefine") ) {
							foundDefine = true;
							defineXml = one;
							break;
						}
						
						if (foundDefine == true) {
							var id:String = defineXml.get("id");
							var title:String = defineXml.get("title");
							
							trace("id" + id);
							trace("title" + title);
							
							if (defineXml.exists("id") == false) {
								trace("ERROR no id from " + childItemPath);
							}
							
							if (defineXml.exists("title") == false) {
								trace("ERROR no id title " + childItemPath);
							}
							
							var panelInfo:PanelInfo = new PanelInfo();
							panelInfo.id = id;
							panelInfo.title = title;
							//panelInfo.body = body;
							
							//todo check same id problem
							
							mapPanelInfo.set(id, panelInfo);
							panelList.push(id);
						}
					}
				}
			}
		}
	}
	
	public function initExts():Void {
		
	}
	
	public function updateExts():Void {
		
	}
	
	public function getEndfix(path:String):String {
		//trace("getEndfix 1 " + path);
		var lastDot:Int = path.lastIndexOf(".");
		if(lastDot >= 0){
			var endFix:String = path.substr(lastDot + 1);
			return endFix;
		}
		return "";
	}
}

class PanelInfo {
	
	public var id:String;
	public var title:String;
	public var body:Xml;
	
	public function new() {
	}
	
}