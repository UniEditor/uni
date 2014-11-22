package editor.render;

import openfl.display.DisplayObject;

/**
 * ...
 * @author GDB
 */
class StageRender extends DisplayObject
{
	
	//singleton
	private static var instance:StageRender;
	public static function getIns():StageRender {
		if (instance == null) {
			instance = new StageRender();
		}
		return instance;
	}
	
	public var cam_zoom:Float;
	public var cam_px:Float;
	public var cam_py:Float;
	public var window_sizeX:Int;
	public var window_sizeY:Int;
	
	public var root:EdObjRender;//the nested structure
	
	public function new() 
	{
		super();
	}
	
	public function init() {
		
	}
	
	//all possible changes:
	//new edObj
	//edObj property changes
	//del edObj
	//nest structure change
	//subsctructure within a type is changed (kinds of pro?)
	//() enter seperation mode
	
	//all possible input
	//position by dragging
	//op with gadgets
	//op with right click
	//selection
	
	//display struction
	//overall
		//gadgets store all gadets
		//content scale and dispos for cam
	
	public function render():Void {
		
	}
	
	
}