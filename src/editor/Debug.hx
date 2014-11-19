package editor;
import editor.event.EventManager;
import editor.event.UniEvent;
import haxe.ds.ArraySort;
import openfl.events.Event;

/**
 * ...
 * @author 
 */
class Debug
{
	
	//singleton
	public static var instance:Debug;
	public static function getIns():Debug {
		if (instance == null) {
			instance = new Debug();
		}
		return instance;
	}
	
	
	public var Max_Log:Int = 3000;
	public var logs:Array<String>;
	

	public function new() 
	{
		logs = new Array<String>();
	}
	
	public function log(str:String):Void {
		trace("LOG:"+str);
		if (logs.length >= Max_Log) {
			logs.shift();
		}
		
		logs.push(str);
		EventManager.getIns().dispatchEvent(new UniEvent(UniEvent.LOG_ADD, str));
	}
	
}