package modules.uniSprite;

import data.EditableObject;
import editor.render.EdObjRender;
import haxe.ui.toolkit.core.interfaces.IDraggable;
import haxe.ui.toolkit.events.UIEvent;
import modules.basic.ProGroupTransformation;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.display.Sprite;

/**
 * ...
 * @author 
 */
class UniSpriteRender extends EdObjRender
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
		
		this.addEventListener(MouseEvent.CLICK, onClick);
	}
	
	override public function render():Void 
	{
		graphics.beginFill(0x000011, 0.3);
		graphics.drawRect(0, 0, 100,100);
		graphics.endFill();
		
		this.x = unisprite.transform.x;
		this.y = unisprite.transform.y;
	}
	
	
	//temp funcs
	private function onClick(e:MouseEvent):Void {
		trace("onClick" + e.currentTarget);
		var us:UniSprite = cast e.currentTarget;
	}
	
}