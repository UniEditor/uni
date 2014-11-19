package editor.event;
import openfl.events.Event;

/**
 * ...
 * @author GDB
 */
class UniEvent extends Event
{
	
	public static var LOG_ADD:String = "LOG_ADD";
	public var data:Dynamic;
	
	public function new(type:String, data_:Dynamic) 
	{
		data = data_;
		super(type);
	}
	
}