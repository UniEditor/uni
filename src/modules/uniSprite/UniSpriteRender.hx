package modules.uniSprite;

import data.EditableObject;
import data.lib.Asset;
import editor.render.EdObjRender;
import editor.Uni;
import haxe.ui.toolkit.core.interfaces.IDraggable;
import haxe.ui.toolkit.events.UIEvent;
import modules.basic.ProTransform;
import openfl.display.Bitmap;
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
	public var bitmap:Bitmap;
	
	public function new()
	{
		super();
		
		mouseEnabled = false;
		mouseChildren = false;
		
		bitmap = new Bitmap();
		addChild(bitmap);
	}
	
	override public function init(edObj_:EditableObject):Void 
	{
		super.init(edObj_);
		unisprite = cast this.edObj;
		
		//this.addEventListener(MouseEvent.CLICK, onClick);
	}
	
	//todo move those transfrom value setting to data; this should only cares about rendering
	override public function render():Void 
	{
		
		this.x = unisprite.transform.x;
		this.y = unisprite.transform.y;
		
		unisprite.transform.width = 100;
		unisprite.transform.height = 100;
		
		graphics.clear();
		bitmap.visible = false;
		
		if (unisprite.spRender.renderType == "rect") {
			
			graphics.beginFill(unisprite.spRender.rect_color, 0.3);
			graphics.drawRect(0, 0, unisprite.spRender.rect_wd, unisprite.spRender.rect_ht);
			graphics.endFill();
			
			unisprite.transform.width = unisprite.spRender.rect_wd;
			unisprite.transform.height = unisprite.spRender.rect_ht;
			
		}else {
			
			bitmap.visible = true;
			
			unisprite.spRender.img_wd = 0;
			unisprite.spRender.img_ht = 0;
			
			
			
			//todo improve this
			for (one in Uni.getIns().mapAsset) {
				if (one.path == unisprite.spRender.img_path || one.fileName == unisprite.spRender.img_path) {
					bitmap.bitmapData = one.bitmapData;
					unisprite.spRender.img_wd = bitmap.bitmapData.width;
					unisprite.spRender.img_ht = bitmap.bitmapData.height;
					unisprite.transform.width = unisprite.spRender.img_wd;
					unisprite.transform.height = unisprite.spRender.img_ht;
					break;
				}
			}
			
		}
	}
	
	//temp funcs
	private function onClick(e:MouseEvent):Void {
		trace("onClick" + e.currentTarget);
		var us:UniSprite = cast e.currentTarget;
		
		Uni.getIns().doSelect(edObj.id);
	}
	
}