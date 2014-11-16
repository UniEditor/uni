package editor;
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
	public static var instance:Uni;
	public static function getIns():Uni {
		if (instance == null) {
			instance = new Uni();
		}
		return instance;
	}
	
	
	
	//holds data for everything
	//lib (symbols, assets)
	//stage object tree
	
	public var mapEdObj:Map<String, EditableObject>;
	public var nestEdObj:Nest;
	
	
	public function new() 
	{
		mapEdObj = new Map<String, EditableObject>();
		nestEdObj = new Nest();
	}
	
	
	//EdObj functions
	//these generate call actions?
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