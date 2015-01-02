package editor.action;

/**
 * @author GDB
 */

interface IAction 
{
  
	public function doAction():Void;
	public function undoAction():Void;
	
	
}