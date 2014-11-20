package editor;
import data.TypeInfo;
import data.EditableObject;
import editor.Uni.Nest;
import haxe.remoting.AMFConnection;
import modules.basic.EdObjActions.EdObjAct_Add;
import modules.basic.EdObjActions.EdObjAct_Remove;

/**
 * Manages data, not ui frames
 * @author GDB
 */
class Uni
{
	
	//singleton
	private static var instance:Uni;
	public static function getIns():Uni {
		if (instance == null) {
			instance = new Uni();
		}
		return instance;
	}
	
	
	//tools
	public var uniTools:UniTools;
	
	//staqe info
	public var mapEdObj:Map<String, EditableObject>;
	public var nestEdObj:Nest;
	
	
	//type info
	public var mapType:Map<String, TypeInfo>;//uni official type and types provided by ext
	public var mapCustomeTpye:Map<String, TypeInfo>;//created by user during a project
	
	
	
	public function new() 
	{
		uniTools = new UniTools();
		
		mapEdObj = new Map<String, EditableObject>();
		nestEdObj = new Nest();
		
		mapCustomeTpye = new Map<String, TypeInfo>();
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	//=====INTERFACES=====
 	//these generate call actions
	
	//Type functions
	
	public function createCustomeType(name:String, baseType:TypeInfo):Void {
		
		
	}
	
	//EdObj functions

	public function createEmptyEdObj():Void {
		
		
		var act:EdObjAct_Add = new EdObjAct_Add();
		act.doAction();
		
		//broadcast event
		
	}
	
	public function removeEdObj(edo:EditableObject):Void {
		
		var act:EdObjAct_Remove = new EdObjAct_Remove();
		act.doAction();
		
		//broadcast event
		
	}
	
	public function editEdObjPro():Void {
		
	}
	
	
	
}

class Nest {
	
	public var id:String;
	public var data:Dynamic;
	public var child:Array<Nest>;
	
	public function new() {
		child = new Array<Nest>();
	}
}