package modules.basic;
import editor.gadget.EdGadget;


/**
 * The halftransparent box showing when doing box selection
 * Resize with mouse drags
 * @author GDB
 */
class GdgSelectBox extends EdGadget
{

	public function new() 
	{
		super();
	}
	
	public function update(rx:Float, ry:Float, wd:Float, ht:Float):Void {
		
		graphics.clear();
		graphics.lineStyle(2, 0xFF0000, 1);
		graphics.beginFill(0x996699,0.4);
		graphics.drawRect(rx, ry, wd, ht);
		graphics.endFill();
	}
	
}