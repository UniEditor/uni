package editor.render;

import data.EdObject;
import openfl.display.DisplayObject;
import openfl.display.Sprite;

/**
 * ...
 * @author GDB
 */
class EdObjRender extends Sprite
{
	
	public var edObj:EdObject; //link back to the data
	
	public function new() 
	{
		super();
	}
	
	//to set the data
	public function init(edObj_:EdObject):Void {
		edObj = edObj_;
	}
	
	public function render():Void {
		//to be override
	}
	
	
}