package modules.uniSprite;

import data.EditableObject;
import editor.render.EdObjRender;
import haxe.ui.toolkit.core.interfaces.IDraggable;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.display.Sprite;

/**
 * ...
 * @author 
 */
class UniSpriteRender extends EdObjRender implements IDraggable
{
	

	public function new() 
	{
		super();
		
		var text:TextField = new TextField();
		text.text = "UniSpriteRender";
		addChild(text);
	}
	
	
	public function allowDrag(event:MouseEvent):Bool {
		return true;
	}
}