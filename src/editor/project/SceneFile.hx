package editor.project;
import data.EdObject;
import data.lib.Asset;
import data.pro.ProGroup;
import editor.event.EventManager;
import editor.event.UniEvent;
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
		trace("loadSelf" + path);
		
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
			trace("load ed:" + edObjXML.nodeName);
			
			var typeStr:String = edObjXML.get("type");			
			var id:String = edObjXML.get("id");
			var typeInfoID:String = edObjXML.get("typeInfoID");
			
			var type:Class<Dynamic> = Type.resolveClass(typeStr);
			var instance:EdObject = Type.createInstance(type, []);
			instance.id = id;
			instance.typeInfoID = typeInfoID;
			
			
			//load progroups
			for (group in edObjXML.elements()) {
				var groupXml:Xml = cast group;
				trace("group" + groupXml.nodeName);
				
				var groupNickName:String = groupXml.nodeName;
				if (instance.proGroups.exists(groupNickName) == false) {
					trace("NO SUCH PROGROUP:" + groupNickName);
					continue;
				}
				
				var progroup:ProGroup = instance.proGroups[groupNickName];
				
				for (field in progroup.fields) {
					var fName:String = field.name;
					//trace("fName" + fName);
					if (groupXml.exists(fName)) {
						//trace("fName exist" + fName);
						var value = groupXml.get(fName);
						
						if (field.type == "F") {
							var valueFloat:Float = Std.parseFloat(value);
							Reflect.setField(progroup, fName, valueFloat);
						}else if (field.type == "N") {
							var valueInt:Int = Std.parseInt(value);
							Reflect.setField(progroup, fName, valueInt);
						}else if (field.type == "S") {
							Reflect.setField(progroup, fName, value);
						}
					}
				}
				
			}
			
			trace(instance.printSelf());
			mapEdObj[id] = instance;
			
			EventManager.getIns().dispatchEvent(new UniEvent(UniEvent.ED_OBJ_ADD, instance.id));
		}
	}
	
}