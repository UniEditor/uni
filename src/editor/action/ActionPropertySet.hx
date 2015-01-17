package editor.action;
import data.EdObject;

/**
 * Each has differnt params
 * @author GDB
 */
class ActionPropertySet implements IAction
{
	
	public var obj:EdObject;
	public var propertyName:String;
	public var propertyValue:Dynamic;
	public var oldValue:Dynamic;
	
	public function new(obj_:EdObject, 
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