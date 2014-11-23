package editor.render;

import data.EditableObject;
import openfl.display.DisplayObject;
import openfl.display.Sprite;

/**
 * ...
 * @author GDB
 */
class EdObjRender extends Sprite
{
	
	public var edObj:EditableObject; //link back to the data
	
	
	public function new() 
	{
		super();
		
		graphics.beginFill(0x000011, 0.3);
		graphics.drawCircle(0, 0, 100);
		graphics.endFill();
	}
	
	
}