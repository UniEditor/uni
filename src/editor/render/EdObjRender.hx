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
	
	private var edObj:EditableObject; //link back to the data
	
	public function new() 
	{
		super();
	}
	
	//to set the data
	public function init(edObj_:EditableObject):Void {
		edObj = edObj_;
	}
	
	public function render():Void {
		//to be override
	}
	
	
}