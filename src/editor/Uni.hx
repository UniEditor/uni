package editor;
import data.TypeInfo;
import data.EditableObject;
import editor.Uni.Nest;
import haxe.remoting.AMFConnection;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.Image;
import haxe.ui.toolkit.controls.Text;
import modules.basic.EdObjActions.EdObjAct_Add;
import modules.basic.EdObjActions.EdObjAct_Remove;

import modules.uniSprite.UniSprite;

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
		
		mapType = new Map<String, TypeInfo>();
		mapCustomeTpye = new Map<String, TypeInfo>();
	}
	
	
	//=====INTERFACES=====
 	//these generate call actions
	
	//Type functions
	
	public function createCustomeType(name:String, baseType:TypeInfo):Void {
		
		
	}
	
	//EdObj functions

	public function createEmptyEdObj(typeInfoId:String):Void {
		var act:EdObjAct_Add = new EdObjAct_Add(typeInfoId);
		act.doAction();
	}
	
	public function removeEdObj(edo:EditableObject):Void {
		var act:EdObjAct_Remove = new EdObjAct_Remove();
		act.doAction();
	}
	
	public function editEdObjPro(edoId:String, proGroupId:String, valueId:String, value:Dynamic):Void {
		var act:EdObjAct_Remove = new EdObjAct_Remove();
		act.doAction();
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