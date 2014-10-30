package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.Toolkit;
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
			//KeyboardManager.init(root);
			//MacroUtil.loadUserPlugins("assets/plugins/user-plugins.xml");
			
			root.addChild(EditorFrame.getIns().view);
			
			var panel:EditorPanel = new EditorPanel();
			root.addChild(panel);
		});
		
		//create main panels
		
		
		//load and init all exts
		
		//load project
		
		
		
		Test.main();
		//Test.benchMark2();
		
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
