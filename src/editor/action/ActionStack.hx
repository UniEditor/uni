package editor.action;

/**
 * ...
 * @author GDB
 */
class ActionStack
{
	
	public var MAX_ACT_STACK_NUM:Int = 200;
	
	public var actStack:Array<IAction>;
	public var actStackPointer:Int;
	
	
	public function new() 
	{
		
	}
	
	public function recordUserAction(action:IAction) {
		
	}
	
	public function undo():Void {
		
	}
	
	public function recover():Void {
		
	}
	
	
}