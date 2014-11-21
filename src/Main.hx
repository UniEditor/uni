package  ;

import editor.extention.ExtManager;
import editor.Uni;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.Toolkit;
import sys.io.Process;
import ui.EditorFrame;
import ui.EditorPanel;

/**
 * Test Edit
 * @author GDB
 */

class Main extends Sprite 
{
	var inited:Bool;
	
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
	

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;
		
		//init steps
		
		
		//load images for use in UI
		
		
		
		//init main UI frame
		Toolkit.init();
		Toolkit.openFullscreen(function(root:Root) {
			root.addChild(EditorFrame.getIns().view);
		});
		
		
		//load and init all exts
		ExtManager.getIns().loadExts();
		
		trace("======listing all exts:======");
		for (one in ExtManager.getIns().mapExt) {
			trace(one.id);
		}
		trace("======listing all panels:======");
		for (one in ExtManager.getIns().mapPanelInfo) {
			trace(one.id + "===" + one.extId);
		}
		trace("======================");
		
		//create major panels
		
		
		//create list under submenu: command, exporters, panels
		EditorFrame.getIns().updateExtSubMenu();
		
		
		//init data core
		Uni.getIns().uniTools.loadTypeList();
		
		trace("======listing TypeList:======");
		for (one in Uni.getIns().mapType) {
			trace(one.name);
		}
		trace("======================");
		
		
		//--------------------------------------------------
		//uni ready
		
		//load user project
		
		

	}
	
	
	
	/* SETUP */
	
	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	
}
