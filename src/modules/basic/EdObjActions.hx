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
		
		var classObj = Type.resolveClass(typeInfo.reflect);
		var edObj:EditableObject = cast Type.createInstance(classObj, []);
		edObj.id = Uni.getIns().uniTools.genEdObjId();
		
		trace("edObj.id:" + edObj.id);
		Uni.getIns().mapEdObj[edObj.id] = edObj;
		
		//todo send msg to update the render's
		
		
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