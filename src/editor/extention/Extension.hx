package editor.extention;
import editor.event.EventManager;
import openfl.events.EventDispatcher;

/**
 * ...
 * @author GDB
 */
class Extension  extends EventDispatcher
{
	
	public var fullPath:String;
	
	public function new() 
	{
		super();
	}
	
	public function sayHello():Void {
		trace("hello from ext:" + fullPath);
	}
	
	public function regFunc_afterInit(func:Dynamic->Void):Void {
		EventManager.getIns().addEventListener(EventManager.EXT_AFTER_INIT,func);
	}
	
}