package data;
import data.pro.ProGroup;
import editor.render.EdObjRender;
import modules.basic.ProTransform;

/**
 * EditorObject might not be the tiniest object on stage or in the layer manager list
 * Yet it defines a standard of all these objects:
	* contains a list of user data
	* is the instance of some symbol

 * @author GDB
 */
class EditableObject
{
	
	//whether should contain child EditorObject
	//Complex objects like tilemap should set this true
	//so that they wont have weird things as children
	public var isFinalNode:Bool;
	
	//for editor only
	public var isLocked:Bool;
	public var isVisible:Bool;
	
	//core data
	public var id:String;
	public var typeInfoID:String;
	
	public var proGroupList:Array<String>;//for proPanel, for a sorted list
	public var proGroups:Map<String,ProGroup>;
	public var renderClass:Class<EdObjRender>;
	
	public function new() 
	{
		proGroupList = new Array<String>();
		proGroups = new Map<String,ProGroup>();
	}
	
	public function get(proGroupName:String):ProGroup {
		return proGroups[proGroupName];
	}
	
	//call at creation
	public function initPos(x:Float, y:Float):Void {
		//can not gurrant all edObj has tranformation, so to be override
		if (proGroups["transform"] != null) {
			var trans:ProTransform = cast proGroups["transform"];//TODO make enum for "transform" stuff?
			trans.x = x;
			trans.y = y;
		}
	}
	
	
}