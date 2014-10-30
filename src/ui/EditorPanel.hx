package ui;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.core.interfaces.IDraggable;
import openfl.events.MouseEvent;

/**
 * ...
 * @author GDB
 */
class EditorPanel extends VBox implements IDraggable
{

	public function new() 
	{
		super();
		
		graphics.beginFill(0x996699, 1);
		graphics.drawRoundRect(0, 0, 100, 200, 10);
		graphics.endFill();
	}
	
	public function allowDrag(event:MouseEvent):Bool {
		return true;
	}
}