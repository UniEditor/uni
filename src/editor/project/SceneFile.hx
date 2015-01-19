package editor.project;
import data.EdObject;
import data.lib.Asset;
import editor.Uni.Nest;
import haxe.macro.Tools.TMacroStringTools;
import sys.io.File;

/**
 * Major data holder for a scene,
 * exist when scene not opened(but main data not loaded)
 * @author GDB
 */
class SceneFile extends Asset
{
	
	//basic
	public var sceneName:String;
	
	//staqe info
	public var mapEdObj:Map<String, EdObject>;
	//public var nestEdObj:Nest; //todo nested structure
	
	public function new() 
	{
		assType = "scene";
		
		sceneName = ProjectManager.getIns().genDefaultSceneName();
		
		mapEdObj = new Map<String, EdObject>();
		//nestEdObj = new Nest();
		
		super();
	}
	
	public function save():String {
		return "";
	}
	
	public function load(data:String):Void {
		
	}
	
	public function loadSelf():Void {
		
		var content:String = File.getContent(path);
		var root:Xml = Xml.parse(content);
		
		var sceneXml:Xml;
		for (one in root.elementsNamed("scene")) {
			sceneXml = one;
			break;
		}
		
		if (sceneXml.exists("scene_name") == false) {
			trace("Error: Project dont have project_name");
			return;
		}
		
		sceneName = sceneXml.get("scene_name");
		
		
		//load edobjs
		for (one in sceneXml.elements()) {
			var edObjXML:Xml = cast one;
			
			var typeStr:String = edObjXML.nodeName;
			trace("typeStr" + typeStr);
			
			
			
		}
		
		//load progroups
		
		
	}
	
}