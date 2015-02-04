package editor.project;
import data.EdObject;
import data.lib.Asset;
import data.pro.ProGroup;
import editor.event.EventManager;
import editor.event.UniEvent;
import editor.Uni.Nest;
import haxe.macro.Tools.TMacroStringTools;
import haxe.ui.toolkit.core.xml.XMLProcessor;
import sys.io.File;
import sys.io.FileOutput;

/**
 * Major data holder for a scene,
 * exist when scene not opened(but main data not loaded)
 * @author GDB
 */
class SceneFile extends Asset
{
	
	//basic
	public var sceneName:String;
	public var stage_width:Int;
	public var stage_height:Int;
	
	//staqe info
	public var mapEdObj:Map<String, EdObject>;
	//public var nestEdObj:Nest; //todo nested structure
	
	public function new() 
	{
		assType = "scene";
		super();
		
		sceneName = ProjectManager.getIns().genDefaultSceneName();
		mapEdObj = new Map<String, EdObject>();
	}
	
	public function save():String {
		trace("save start");
		
		var docXml:Xml = Xml.createDocument();
		
		var sceneXml:Xml = Xml.createElement("scene");
		sceneXml.set("scene_name", sceneName);
		sceneXml.set("stage_width", stage_width+"");
		sceneXml.set("stage_height", stage_height+"");
		docXml.addChild(sceneXml);
		
		//add all object
		for(one in mapEdObj){
			
			var edObj:EdObject = cast one;
			var edObjXml:Xml = Xml.createElement("EdObj");
			
			var edClass:Class<EdObject> = Type.getClass(edObj);
			var classNameLong:String = Type.getClassName(edClass);
			
			edObjXml.set("type", classNameLong);
			edObjXml.set("id", edObj.id);
			edObjXml.set("typeInfoID", edObj.typeInfoID);
			
			//add progroups
			for(other in edObj.proGroupList){
				
				var proGroup:ProGroup = edObj.proGroups[other];
				var proGoupXml:Xml = Xml.createElement(other);
				
				trace("proGroup start: " + proGroup);
				
				for (another in proGroup.fields) {
					trace("proField start: " + another);
					
					var proField:ProField = cast another;
					var value:Dynamic = Reflect.getProperty(proGroup, proField.name);
					proGoupXml.set(proField.name, value);
				}
				edObjXml.addChild(proGoupXml);
				
				trace("proGroup done: " + proGroup);
			}
			sceneXml.addChild(edObjXml);
		}
		
		return docXml.toString();
	}
	
	public function saveSelf():Void{
		
		trace("path: " + path);
		if(path == ""){
			//this file is has not save-as yet
			//return;
			
			path = ProjectManager.getIns().currentPoject.assetPath + "/" + sceneName;
		}
		
		var content:String = save();
		trace("content: " + content);
		
		var fop:FileOutput  = File.write(path,false);
		fop.writeString(content);
		fop.close();
		
		trace("saveSelf success: " + path);
	}
	
	
	public function load(dataStr:String):Void{
		
		var root:Xml = Xml.parse(dataStr);
		
		var sceneXml:Xml;
		for (one in root.elementsNamed("scene")) {
			sceneXml = one;
			break;
		}
		
		if (sceneXml.exists("scene_name") == false) {
			trace("Error: Project dont have scene_name");
			return;
		}
		
		if (sceneXml.exists("stage_width") == false) {
			trace("Error: Project dont have stage_width");
			return;
		}
		
		if (sceneXml.exists("stage_height") == false) {
			trace("Error: Project dont have stage_height");
			return;
		}
		
		sceneName = sceneXml.get("scene_name");
		stage_width = Std.parseInt(sceneXml.get("stage_width"));
		stage_height = Std.parseInt(sceneXml.get("stage_height"));
		
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
	
	public function loadSelf():Void {
		
		if(path == ""){
			//this file is just created in memory
			return;
		}
		
		trace("loadSelf" + path);
		
		var content:String = File.getContent(path);
		load(content);
	}
	
}