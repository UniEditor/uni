package ui;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.core.interfaces.IDraggable;
import haxe.ui.toolkit.core.Toolkit;
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
		
		var frame = Toolkit.processXmlResource("ui/panels/panel_frame.xml");
		addChild(frame);
		
		trace(frame);
		
		frame.width = 200;
		frame.height = 200;
		
		
		//graphics.beginFill(0x996699, 1);
		//graphics.drawRoundRect(0, 0, 100, 200, 10);
		//graphics.endFill();
	}
	
	public function allowDrag(event:MouseEvent):Bool {
		return true;
	}
}