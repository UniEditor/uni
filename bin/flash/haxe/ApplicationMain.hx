import lime.Assets;
#if !macro


class ApplicationMain {
	
	
	public static var config:lime.app.Config;
	public static var preloader:openfl.display.Preloader;
	
	private static var app:lime.app.Application;
	
	
	public static function create ():Void {
		
		app = new openfl.display.Application ();
		app.create (config);
		
		var display = new NMEPreloader ();
		
		preloader = new openfl.display.Preloader (display);
		preloader.onComplete = init;
		preloader.create (config);
		
		#if js
		var urls = [];
		var types = [];
		
		
		urls.push ("styles/default/circle.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/default/collapse.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/default/cross.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/default/expand.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/default/up_down.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/gradient/arrow_down.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/gradient/arrow_down_dark.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/gradient/arrow_down_disabled.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/gradient/arrow_left.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/gradient/arrow_left_disabled.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/gradient/arrow_right.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/gradient/arrow_right2.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/gradient/arrow_right_dark.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/gradient/arrow_right_disabled.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/gradient/arrow_up.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/gradient/arrow_up_disabled.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/gradient/circle_dark.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/gradient/cross_dark.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/gradient/cross_dark_disabled.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/gradient/gradient.css");
		types.push (AssetType.TEXT);
		
		
		urls.push ("styles/gradient/gradient.min.css");
		types.push (AssetType.TEXT);
		
		
		urls.push ("styles/gradient/gradient_mobile.css");
		types.push (AssetType.TEXT);
		
		
		urls.push ("styles/gradient/gradient_mobile.min.css");
		types.push (AssetType.TEXT);
		
		
		urls.push ("styles/gradient/gripper_horizontal.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/gradient/gripper_horizontal_disabled.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/gradient/gripper_vertical.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/gradient/gripper_vertical_disabled.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/windows/accordion.css");
		types.push (AssetType.TEXT);
		
		
		urls.push ("styles/windows/accordion.min.css");
		types.push (AssetType.TEXT);
		
		
		urls.push ("styles/windows/button.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/windows/buttons.css");
		types.push (AssetType.TEXT);
		
		
		urls.push ("styles/windows/buttons.min.css");
		types.push (AssetType.TEXT);
		
		
		urls.push ("styles/windows/calendar.css");
		types.push (AssetType.TEXT);
		
		
		urls.push ("styles/windows/checkbox.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/windows/container.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/windows/glyphs/down_arrow.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/windows/glyphs/hscroll_thumb_gripper_down.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/windows/glyphs/hscroll_thumb_gripper_over.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/windows/glyphs/hscroll_thumb_gripper_up.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/windows/glyphs/left_arrow.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/windows/glyphs/right_arrow.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/windows/glyphs/up_arrow.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/windows/glyphs/vscroll_thumb_gripper_down.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/windows/glyphs/vscroll_thumb_gripper_over.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/windows/glyphs/vscroll_thumb_gripper_up.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/windows/hprogress.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/windows/hscroll.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/windows/listview.css");
		types.push (AssetType.TEXT);
		
		
		urls.push ("styles/windows/listview.min.css");
		types.push (AssetType.TEXT);
		
		
		urls.push ("styles/windows/listview.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/windows/menus.css");
		types.push (AssetType.TEXT);
		
		
		urls.push ("styles/windows/optionbox.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/windows/popup.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/windows/popups.css");
		types.push (AssetType.TEXT);
		
		
		urls.push ("styles/windows/rtf.css");
		types.push (AssetType.TEXT);
		
		
		urls.push ("styles/windows/scrolls.css");
		types.push (AssetType.TEXT);
		
		
		urls.push ("styles/windows/scrolls.min.css");
		types.push (AssetType.TEXT);
		
		
		urls.push ("styles/windows/sliders.css");
		types.push (AssetType.TEXT);
		
		
		urls.push ("styles/windows/tab.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/windows/tabs.css");
		types.push (AssetType.TEXT);
		
		
		urls.push ("styles/windows/textinput.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/windows/vprogress.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/windows/vscroll.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("styles/windows/windows.css");
		types.push (AssetType.TEXT);
		
		
		urls.push ("img/slinky.jpg");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/slinky_large.jpg");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/slinky_small.jpg");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/slinky_tiny.jpg");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("fonts/Oxygen-Bold.ttf");
		types.push (AssetType.FONT);
		
		
		urls.push ("fonts/Oxygen.ttf");
		types.push (AssetType.FONT);
		
		
		urls.push ("img/cross-small.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/exclamation.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/icons/binocular--pencil.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/icons/binocular.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/icons/control.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/icons/disk-black.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/icons/disks-black.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/icons/document-medium.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/icons/document.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/icons/folder-open-document.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/icons/gear.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("img/icons/wrench-screwdriver.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("ui/document.xml");
		types.push (AssetType.TEXT);
		
		
		urls.push ("ui/main.xml");
		types.push (AssetType.TEXT);
		
		
		urls.push ("ui/menus/edit.xml");
		types.push (AssetType.TEXT);
		
		
		urls.push ("ui/menus/file.xml");
		types.push (AssetType.TEXT);
		
		
		urls.push ("ui/menus/help.xml");
		types.push (AssetType.TEXT);
		
		
		urls.push ("ui/menus/program.xml");
		types.push (AssetType.TEXT);
		
		
		urls.push ("ui/menus/search.xml");
		types.push (AssetType.TEXT);
		
		
		urls.push ("ui/popups/about.xml");
		types.push (AssetType.TEXT);
		
		
		urls.push ("ui/popups/find-replace.xml");
		types.push (AssetType.TEXT);
		
		
		urls.push ("ui/popups/find.xml");
		types.push (AssetType.TEXT);
		
		
		urls.push ("ui/preferences/main.xml");
		types.push (AssetType.TEXT);
		
		
		urls.push ("ui/preferences/prefs-defaults.xml");
		types.push (AssetType.TEXT);
		
		
		urls.push ("ui/preferences/prefs-test.xml");
		types.push (AssetType.TEXT);
		
		
		urls.push ("ui/toolbar.xml");
		types.push (AssetType.TEXT);
		
		
		urls.push ("ui/warnings/flash-only.xml");
		types.push (AssetType.TEXT);
		
		
		urls.push ("ui/warnings/not-implemented.xml");
		types.push (AssetType.TEXT);
		
		
		
		preloader.load (urls, types);
		#end
		
		var result = app.exec ();
		
		#if sys
		Sys.exit (result);
		#end
		
	}
	
	
	public static function init ():Void {
		
		var loaded = 0;
		var total = 0;
		var library_onLoad = function (_) {
			
			loaded++;
			
			if (loaded == total) {
				
				start ();
				
			}
			
		}
		
		
		
		if (loaded == total) {
			
			start ();
			
		}
		
	}
	
	
	public static function main () {
		
		config = {
			
			antialiasing: Std.int (0),
			background: Std.int (16777215),
			borderless: false,
			depthBuffer: false,
			fps: Std.int (60),
			fullscreen: false,
			height: Std.int (640),
			orientation: "",
			resizable: true,
			stencilBuffer: false,
			title: "UNI",
			vsync: false,
			width: Std.int (1024),
			
		}
		
		#if js
		#if munit
		flash.Lib.embed (null, 1024, 640, "FFFFFF");
		#end
		#else
		create ();
		#end
		
	}
	
	
	public static function start ():Void {
		
		openfl.Lib.current.stage.align = openfl.display.StageAlign.TOP_LEFT;
		openfl.Lib.current.stage.scaleMode = openfl.display.StageScaleMode.NO_SCALE;
		
		var hasMain = false;
		
		for (methodName in Type.getClassFields (Main)) {
			
			if (methodName == "main") {
				
				hasMain = true;
				break;
				
			}
			
		}
		
		if (hasMain) {
			
			Reflect.callMethod (Main, Reflect.field (Main, "main"), []);
			
		} else {
			
			var instance:DocumentClass = Type.createInstance (DocumentClass, []);
			
			if (Std.is (instance, openfl.display.DisplayObject)) {
				
				openfl.Lib.current.addChild (cast instance);
				
			}
			
		}
		
		openfl.Lib.current.stage.dispatchEvent (new openfl.events.Event (openfl.events.Event.RESIZE, false, false));
		
	}
	
	
	#if neko
	@:noCompletion public static function __init__ () {
		
		var loader = new neko.vm.Loader (untyped $loader);
		loader.addPath (haxe.io.Path.directory (Sys.executablePath ()));
		loader.addPath ("./");
		loader.addPath ("@executable_path/");
		
	}
	#end
	
	
}


#if flash @:build(DocumentClass.buildFlash())
#else @:build(DocumentClass.build()) #end
@:keep class DocumentClass extends Main {}


#else


import haxe.macro.Context;
import haxe.macro.Expr;


class DocumentClass {
	
	
	macro public static function build ():Array<Field> {
		
		var classType = Context.getLocalClass ().get ();
		var searchTypes = classType;
		
		while (searchTypes.superClass != null) {
			
			if (searchTypes.pack.length == 2 && searchTypes.pack[1] == "display" && searchTypes.name == "DisplayObject") {
				
				var fields = Context.getBuildFields ();
				
				var method = macro {
					
					this.stage = flash.Lib.current.stage;
					super ();
					dispatchEvent (new openfl.events.Event (openfl.events.Event.ADDED_TO_STAGE, false, false));
					
				}
				
				fields.push ({ name: "new", access: [ APublic ], kind: FFun({ args: [], expr: method, params: [], ret: macro :Void }), pos: Context.currentPos () });
				
				return fields;
				
			}
			
			searchTypes = searchTypes.superClass.t.get ();
			
		}
		
		return null;
		
	}
	
	
	macro public static function buildFlash ():Array<Field> {
		
		var classType = Context.getLocalClass ().get ();
		var searchTypes = classType;
		
		while (searchTypes.superClass != null) {
			
			if (searchTypes.pack.length == 2 && searchTypes.pack[1] == "display" && searchTypes.name == "DisplayObject") {
				
				var fields = Context.getBuildFields ();
				var method = macro {
					return flash.Lib.current.stage;
				}
				
				fields.push ({ name: "get_stage", access: [ APrivate ], meta: [ { name: ":getter", params: [ macro stage ], pos: Context.currentPos() } ], kind: FFun({ args: [], expr: method, params: [], ret: macro :flash.display.Stage }), pos: Context.currentPos() });
				return fields;
				
			}
			
			searchTypes = searchTypes.superClass.t.get ();
			
		}
		
		return null;
		
	}
	
	
}


#end