package editor.render;

import data.EditableObject;
import editor.event.EventManager;
import editor.event.UniEvent;
import editor.gadget.EdGadget;
import haxe.ds.Vector;
import haxe.ui.toolkit.core.Component;
import haxe.ui.toolkit.core.interfaces.IDraggable;
import haxe.ui.toolkit.events.UIEvent;
import modules.basic.GdgSelectBox;
import openfl._v2.events.MouseEvent;
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
	
	//data
	public var cam_zoom:Float;
	public var cam_px:Float;
	public var cam_py:Float;
	public var stage_sizeX:Int;
	public var stage_sizeY:Int;
	
	public var dragging:Bool;
	public var stageDragPx:Float;
	public var stageDragPy:Float;
	
	//entities
	public var gadgetLayer:Sprite;
	public var contentLayer:EdObjRender;//the nested structure, dispos and scale
	public var selectBox:GdgSelectBox;
	public var selGadgetList:Array<EdGadget>;
	
	public var mapInstance:Map<String, EdObjRender>;
	public var preselectList:Array<EdObjRender>;//things selected before mouse up
	
	public function new() 
	{
		super();
		
		mapInstance = new Map<String, EdObjRender>();
		preselectList = new Array<EdObjRender>();
		selGadgetList = new Array<EdGadget>();
		dragging = false;
		
		init();
	}
	
	public function init() {
		trace("StageRender init");
		
		
		contentLayer = new EdObjRender();
		addChild(contentLayer);
		gadgetLayer = new Sprite();
		addChild(gadgetLayer);
		selectBox = new GdgSelectBox();
		addChild(selectBox);
		
		EditorFrame.getIns().mainBox.sprite.addChild(this);
		stage_sizeX = cast EditorFrame.getIns().mainBox.width;
		stage_sizeY = cast EditorFrame.getIns().mainBox.height;
		render();
		
		EditorFrame.getIns().mainBox.addEventListener(UIEvent.RESIZE, onResize);
		EventManager.getIns().addEventListener(UniEvent.ED_OBJ_ADD, onEdObjAdd);
		EventManager.getIns().addEventListener(UniEvent.ED_OBJ_PRO_EDIT, onEdObjChange);
		EventManager.getIns().addEventListener(UniEvent.SEL_CHANGE, updateSelGadget);
		
		addEventListener(MouseEvent.MOUSE_DOWN, onStageMouseDown);
		addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
		addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
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
		
		mapInstance[edObj.id] = renderInstance;
		contentLayer.addChild(renderInstance);
	}
	
	private function onEdObjChange(e:UniEvent):Void {
		trace("stageRender:edObj_change " + e.data);
		if (e.data == null) return;
		
		var edObj:EditableObject = Uni.getIns().mapEdObj[e.data];
		if (edObj == null) return;
		
		var renderInstance = mapInstance[edObj.id];
		if (renderInstance == null) return;
		
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
		graphics.beginFill(0x4F4F4F);
		graphics.drawRoundRect(0, 0, stage_sizeX, stage_sizeY, 16);
		graphics.endFill();
	}
	
	public function updateSelGadget():Void {
		
	}
	
	public function onStageMouseDown(e:MouseEvent):Void {
		trace("localX " + e.localX);
		trace("localY " + e.localY);
		
		//todo run alg and get which item is selected
		//todo must select the one on top
		
		var hitAnyOne:Bool = false;
		
		for (one in mapInstance) {
			trace("one:" + one.x + "=" + one.y + "==" + (one.x+one.width) + "=" + (one.y+one.height));
			if (e.localX > one.x && e.localX < one.x+one.width && e.localY > one.y && e.localY < one.y+one.height) {
				
				Uni.getIns().doSelect(one.edObj.id);
				hitAnyOne = false;
				//trace("stage got:" + one.edObj.id);
				break;
			}
		}
		
		dragging = true;
		stageDragPx = e.localX;
		stageDragPy = e.localY;
		
		//if(hitAnyOne)
	}
	
	
	public function onStageMouseMove(e:MouseEvent):Void {
		if (dragging) {
			selectBox.visible = true;
			selectBox.update(stageDragPx, stageDragPy, e.localX - stageDragPx, e.localY - stageDragPy);
			
			//todo update preselctlist by selbox
		}
	}
	
	public function onStageMouseUp(e:MouseEvent):Void {
		selectBox.visible = false;
		dragging = false;
	}
}