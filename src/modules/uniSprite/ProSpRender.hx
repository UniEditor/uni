package modules.uniSprite;

import data.pro.ProGroup;

/**
 * Render setting for sprite
 * @author 
 */


class ProSpRender extends ProGroup
{
	
	public var renderType:String;//image, rect, circle
	
	public var drawColor:Int;
	public var drawOpacity:Int;
	
	public var imgPath:Int;
	public var imgSizeX:Int;//read only for pro
	public var imgSizeY:Int;//read only for pro
	
	public var rect_wd:Float;
	public var rect_ht:Float;
	
	
	public function new() 
	{
		super();
		
		displayName = "Render Setting";
		
		renderType = "rect";
	}
	
}