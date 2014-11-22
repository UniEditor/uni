package modules.basic;

import data.EditableObject;
import data.TypeInfo;
import editor.action.IAction;
import editor.Uni;

/**
 * ...
 * @author 
 */

class EdObjAct_Add implements IAction
{
	
	public var typeId:String;
	
	public function new(typeId_:String) 
	{
		typeId = typeId_;
	}
	
	/* INTERFACE editor.action.IAction */
	
	public function doAction():Void 
	{
		trace("doAction " + typeId);
		if (typeId == null) return;
		
		var typeInfo:TypeInfo = Uni.getIns().mapType[typeId];
		if(typeInfo == null) return;
		
		trace("creating: " + typeInfo.reflect);
		
		var classObj = Type.resolveClass(typeInfo.reflect);
		
		
		trace(classObj);
	}
	
	public function undoAction():Void 
	{
		
	}
	
}

class EdObjAct_Remove implements IAction
{
	
	
	
	public function new() 
	{
		
	}
	
	/* INTERFACE editor.action.IAction */
	
	public function doAction():Void 
	{
		
	}
	
	public function undoAction():Void 
	{
		
	}
	
}