package modules.basic;
import editor.event.EventManager;
import editor.event.UniEvent;
import editor.gadget.EdGadget;
import editor.render.EdObjRender;
import editor.render.StageRender;
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
		StageRender.getIns().addEventListener(MouseEvent.MOUSE_MOVE, onBoxMouseMove);
		addEventListener(MouseEvent.MOUSE_UP, onBoxMouseUp);
	}
	
	public function render():Void {
		if (linkedRender == null) return; 
		
		x = linkedRender.x;
		y = linkedRender.y;
		
		graphics.clear();
		graphics.beginFill(0x996699, 0);
		graphics.lineStyle(2,0x0011FF,0.7);
		graphics.drawRect(0,0,linkedRender.width,linkedRender.height);
	}
	
	public var dragging:Bool;
	private var draggingPosX:Float;
	private var draggingPosY:Float;
	
	public function onBoxMouseDown(e:Dynamic):Void {
		dragging = true;
		draggingPosX = e.stageX - x;
		draggingPosY = e.stageY - y;
	}
	
	public function onBoxMouseMove(e:MouseEvent):Void {
		if (dragging) {
			x = e.stageX - draggingPosX;
			y = e.stageY - draggingPosY;
			linkedRender.x = x;
			linkedRender.y = y;
		}
	}
	
	public function onBoxMouseUp(e:Dynamic):Void {
		dragging = false;
		
		//set pos
		var trans:ProGroupTransformation = cast linkedRender.edObj.get("transform");
		if (trans != null) {
			trans.x = linkedRender.x;
			trans.y = linkedRender.y;
			
			EventManager.getIns().dispatchEvent(new UniEvent(UniEvent.ED_OBJ_PRO_EDIT, linkedRender.edObj.id));
			EventManager.getIns().dispatchEvent(new UniEvent(UniEvent.SEL_CHANGE, linkedRender.edObj.id));
		}
	}
}