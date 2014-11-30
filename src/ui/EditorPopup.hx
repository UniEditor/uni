package ui;
import haxe.ui.toolkit.core.Component;
import haxe.ui.toolkit.core.interfaces.IDraggable;
import openfl._v2.events.MouseEvent;

/**
 * It has a title, closeBtn, and then the content
 * In use for exporter panel
 * @author 
 */
class EditorPopup extends Component implements IDraggable
{

	public function new() 
	{
		super();
	}
	
	public function init(title:String, contentXml: Xml):Void {
		
		
	}
	
	public function allowDrag(event:MouseEvent):Bool {
		return true;
	}
	
}