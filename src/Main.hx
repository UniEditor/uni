package  ;

import editor.extention.ExtManager;
import editor.render.StageRender;
import editor.Uni;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import haxe.ui.toolkit.core.ClassManager;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.Toolkit;

import sys.io.Process;
import ui.controls.ProField;
import ui.controls.ProFrame;
import ui.EditorFrame;
import ui.EditorPanel;
import Weblog;

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
		
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;
		
		Weblog.statsStart();
		Weblog.tic("mainStart");
		trace("======Main Init:======");
		
		
		//init data core
		trace("======Load Type List======");
		Uni.getIns().uniTools.loadTypeList();
		trace("---listing TypeList:---");
		for (one in Uni.getIns().mapType) {
			trace(one.name);
		}
		
		
		//load images for use in UI
		
		
		//init main UI frame
		trace("======UI Frame======");
		ClassManager.instance.registerComponentClass(ProField, "profield");
		ClassManager.instance.registerComponentClass(ProFrame, "proframe");
		Toolkit.init();
		Toolkit.openFullscreen(function(root:Root) {
			root.addChild(EditorFrame.getIns().view);
		});
		
		
		//load and init all exts
		trace("======Load All Exts======");
		ExtManager.getIns().loadExts();
		trace("---list of ext---");
		for (one in ExtManager.getIns().mapExt) {
			trace(one.id);
		}
		trace("---list of panel---");
		for (one in ExtManager.getIns().mapPanelInfo) {
			trace(one.id + "===" + one.extId);
		}
		
		//create major panels
		
		
		//create list under submenu: command, exporters, panels
		trace("======Update Ext Sub Menu======");
		EditorFrame.getIns().init();
		
		
		
		
		//init stage render
		trace("======Stage Render Init======");
		StageRender.getIns();
		
		//--------------------------------------------------
		//uni ready
		
		//load user project
		
		Weblog.toc("mainStart");
		
		
		
		//var config = { width : 100, height : 100 };
		//var win:Window = new Window(config);
		//Lib.application.addWindow(win);
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
