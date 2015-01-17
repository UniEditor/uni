package editor.project;
import data.EdObject;
import data.lib.Asset;
import editor.Uni.Nest;
import haxe.macro.Tools.TMacroStringTools;

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
	
	
	
}