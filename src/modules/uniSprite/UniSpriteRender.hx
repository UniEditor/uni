package modules.uniSprite;

import data.EditableObject;
import editor.render.EdObjRender;
import haxe.ui.toolkit.core.interfaces.IDraggable;
import modules.basic.ProGroupTransformation;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.display.Sprite;

/**
 * ...
 * @author 
 */
class UniSpriteRender extends EdObjRender implements IDraggable
{
	
	public var unisprite:UniSprite;

	public function new() 
	{
		super();
		
		var text:TextField = new TextField();
		text.text = "UniSpriteRender";
		addChild(text);
	}
	
	override public function init(edObj_:EditableObject):Void 
	{
		super.init(edObj_);
		unisprite = cast this.edObj;
	}
	
	override public function render():Void 
	{
		graphics.beginFill(0x000011, 0.3);
		graphics.drawRect(0, 0, 100,100);
		graphics.endFill();
		
		this.x = unisprite.transform.x;
		this.y = unisprite.transform.y;
	}
	
	public function allowDrag(event:MouseEvent):Bool {
		return true;
	}
}