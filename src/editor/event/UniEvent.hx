package editor.event;
import openfl.events.Event;

/**
 * ...
 * @author GDB
 */
class UniEvent extends Event
{
	
	public static var LOG_ADD:String = "LOG_ADD";
	
	public static var ED_OBJ_ADD:String = "EDOBJ_ADD";
	public static var ED_OBJ_REMOVE:String = "ED_OBJ_REMOVE";
	public static var ED_OBJ_PRO_EDIT:String = "ED_OBJ_PRO_EDIT";
	public static var ED_OBJ_NEST_CHANGE:String = "ED_OBJ_NEST_CHANGE";
	
	
	
	public var data:Dynamic;
	
	public function new(type:String, data_:Dynamic) 
	{
		data = data_;
		super(type);
	}
	
}