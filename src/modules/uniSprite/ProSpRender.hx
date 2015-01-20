package modules.uniSprite;

import data.pro.ProGroup;

/**
 * Render setting for sprite
 * @author 
 */


class ProSpRender extends ProGroup
{
	
	public var renderType:String;//image, rect, sprite-sheet

	public var img_path:String;
	public var img_wd:Int;//read only for pro
	public var img_ht:Int;//read only for pro
	
	public var rect_wd:Float;
	public var rect_ht:Float;
	public var rect_color:Int;
	
	public function new() 
	{
		super();
		
		displayName = "Render Setting";
		renderType = "rect";
		
		img_path = "";
		img_wd = 100;
		img_ht = 100;
	
		rect_wd = 100;
		rect_ht = 100;
		rect_color = 0xFF0000;
		
		
		fields.push(new ProField("renderType", "S"));
		fields.push(new ProField("img_path", "S"));
		fields.push(new ProField("img_wd", "N"));
		fields.push(new ProField("img_ht", "N"));
		fields.push(new ProField("rect_wd", "F"));
		fields.push(new ProField("rect_ht", "F"));
		fields.push(new ProField("rect_color", "N"));
	}
	
}