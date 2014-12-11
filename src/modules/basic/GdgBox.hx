package modules.basic;
import editor.gadget.EdGadget;
import editor.render.EdObjRender;
import openfl.events.MouseEvent;

/**
 * ...
 * @author GDB
 */
class GdgBox extends EdGadget
{
	
	public var linkedRender:EdObjRender;
	
	public function new() 
	{
		super();
		
		addEventListener(MouseEvent.MOUSE_DOWN, onBoxMouseDown);
		addEventListener(MouseEvent.MOUSE_MOVE, onBoxMouseMove);
		addEventListener(MouseEvent.MOUSE_UP, onBoxMouseUp);
	}
	
	public function render():Void {
		if (linkedRender == null) return; 
		
		x = linkedRender.x;
		y = linkedRender.y;
		
		graphics.clear();
		graphics.beginFill(0x996699);
		graphics.drawRect(0,0,linkedRender.width,linkedRender.height);
	}
	
	private var dragging:Bool;
	private var draggingPosX:Int;
	private var draggingPosY:Int;
	
	public function onBoxMouseDown(e:Dynamic):Void {
		trace("md");
	}
	
	public function onBoxMouseMove(e:Dynamic):Void {
		trace("mm");
	}
	
	public function onBoxMouseUp(e:Dynamic):Void {
		trace("mu");
	}
}