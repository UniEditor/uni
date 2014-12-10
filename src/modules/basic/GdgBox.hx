package modules.basic;
import editor.gadget.EdGadget;

/**
 * ...
 * @author GDB
 */
class GdgBox extends EdGadget
{
	
	public function new() 
	{
		
	}
	
	public function render():Void {
		
		graphics.clear();
		graphics.beginFill(0x996699);
		graphics.drawRect();
	}
	
}