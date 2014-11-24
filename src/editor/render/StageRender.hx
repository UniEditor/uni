package editor.render;

import data.EditableObject;
import editor.event.EventManager;
import editor.event.UniEvent;
import haxe.ui.toolkit.core.Component;
import haxe.ui.toolkit.core.interfaces.IDraggable;
import haxe.ui.toolkit.events.UIEvent;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import ui.EditorFrame;

/**
 * ...
 * @author GDB
 */
class StageRender extends Sprite
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
	public var stage_sizeX:Int;
	public var stage_sizeY:Int;
	
	public var gadgetLayer:Sprite;
	public var contentLayer:EdObjRender;//the nested structure, dispos and scale
	
	public function new() 
	{
		super();
		init();
	}
	
	public function init() {
		trace("StageRender init");
		
		
		contentLayer = new EdObjRender();
		addChild(contentLayer);
		gadgetLayer = new Sprite();
		addChild(gadgetLayer);
		
		EditorFrame.getIns().mainBox.sprite.addChild(this);
		stage_sizeX = cast EditorFrame.getIns().mainBox.width;
		stage_sizeY = cast EditorFrame.getIns().mainBox.height;
		render();
		
		EditorFrame.getIns().mainBox.addEventListener(UIEvent.RESIZE, onResize);
		EventManager.getIns().addEventListener(UniEvent.ED_OBJ_ADD, onEdObjAdd);
	}
	
	
	private function onResize(e) {
		trace("stage render resize");
		
		stage_sizeX = e.component.width;
		stage_sizeY = e.component.height;
		render();
	}
	
	private function onEdObjAdd(e:UniEvent):Void {
		trace("stageRender:edObj_add " + e.data);
		if (e.data == null) return;

		var edObj:EditableObject = Uni.getIns().mapEdObj[e.data];
		if (edObj == null) return;
		
		var theClass:Class<EdObjRender> = edObj.renderClass;
		if (theClass == null) return;
		
		var renderInstance:EdObjRender = cast Type.createInstance(theClass, []);
		if (renderInstance == null) return;
		
		renderInstance.init(edObj);
		renderInstance.render();
		
		contentLayer.addChild(renderInstance);
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
		graphics.clear();
		graphics.beginFill(0x996699);
		graphics.drawRoundRect(0, 0, stage_sizeX, stage_sizeY, 16);
		graphics.endFill();
	}
	
	
}