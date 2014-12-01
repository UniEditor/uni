package modules.basic;

import data.EditableObject;
import data.pro.ProGroup;
import data.TypeInfo;
import editor.action.IAction;
import editor.event.EventManager;
import editor.event.UniEvent;
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
		edObj.typeInfoID = typeId;
		edObj.initPos(500, 500);//todo replace with stage cam's center pos
		
		Uni.getIns().mapEdObj[edObj.id] = edObj;
		//todo add to nest structure
		trace("mapEdObj: " + Uni.getIns().mapEdObj.toString());
		//todo send msg to update the render's
		EventManager.getIns().dispatchEvent(new UniEvent(UniEvent.ED_OBJ_ADD, edObj.id));
		
		//select the newly created things
		Uni.getIns().doSelect(edObj.id);
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

class EdObjAct_Edit implements IAction
{
	
	
	public var edObjID:String;
	public var proName:String;
	public var fieldName:String;
	public var value:Dynamic;
	
	public function new(edObjID_:String, proName_:String, fieldName_:String, value_:Dynamic) 
	{
		edObjID = edObjID_;
		proName = proName_;
		fieldName = fieldName_;
		value = value_;
	}
	
	/* INTERFACE editor.action.IAction */
	
	public function doAction():Void 
	{
		trace("action edObj edit start");
		var edObj:EditableObject = Uni.getIns().mapEdObj[edObjID];
		var proGroup:ProGroup = edObj.get(proName);
		
		Reflect.setField(proGroup, fieldName, value);
		
		//trigger value change event
		EventManager.getIns().dispatchEvent(new UniEvent(UniEvent.ED_OBJ_PRO_EDIT, edObjID));
		
		if(Uni.getIns().selectedId == edObjID){
			EventManager.getIns().dispatchEvent(new UniEvent(UniEvent.SEL_EB_OBJ_PRO_EDIT, null));
		}
		
		trace("action edObj edit end");
	}
	
	public function undoAction():Void 
	{
		
	}
	
}