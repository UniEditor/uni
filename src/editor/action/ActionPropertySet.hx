package editor.action;
import data.EditableObject;

/**
 * Each has differnt params
 * @author GDB
 */
class ActionPropertySet implements IAction
{
	
	public var obj:EditableObject;
	public var propertyName:String;
	public var propertyValue:Dynamic;
	public var oldValue:Dynamic;
	
	public function new(obj_:EditableObject, 
						propertyName_:String,
						propertyValue_:Dynamic,
						oldValue_:Dynamic) 
	{
		obj = obj_;
		propertyName = propertyName_;
		propertyValue = propertyValue_;
		oldValue = oldValue_;
	}
	
	/* INTERFACE editor.action.IAction */
	
	public function doAction():Void 
	{
		obj[propertyName] = propertyValue;
	}
	
	public function undoAction():Void 
	{
		obj[propertyName] = oldValue;
	}
	
}