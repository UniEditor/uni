package editor.event;
import openfl.events.EventDispatcher;

/**
 * ...
 * @author GDB
 */
class EventManager extends EventDispatcher
{
	
	//singleton
	public static var instance:EventManager;
	public static function getIns():EventManager {
		if (instance == null) {
			instance = new EventManager();
		}
		return instance;
	}
	
	public static var EXT_AFTER_INIT:String = "EXT_AFTER_INIT";
	
	public function new() 
	{
		super();
	}
	
}