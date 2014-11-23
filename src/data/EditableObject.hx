package data;
import data.pro.ProGroup;
import editor.render.EdObjRender;

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
	public var proGroups:Array<ProGroup>;
	
	public var renderClass:Class<EdObjRender>;
	
	public function new() 
	{
		
	}
	
}