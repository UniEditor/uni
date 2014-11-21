package editor.extention;
import data.TypeInfo;
import editor.Debug;
import editor.event.EventManager;
import editor.event.UniEvent;
import editor.extention.ExtManager.PanelInfo;
import editor.Uni;
import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.Image;
import haxe.ui.toolkit.controls.Text;
import haxe.ui.toolkit.events.UIEvent;
import haxe.ui.toolkit.hscript.ScriptInterp;
import hscript.Interp;
import openfl.events.EventDispatcher;
import ui.EditorFrame;
import ui.EditorPanel;

/**
 * ...
 * @author GDB
 */
class Extension extends EventDispatcher
{
	
	public var id:String;
	
	public var fullPath:String;
	public var panelId:String;
	
	//function to override in script
	public var onInit:Void->Void;
	public var onPanelOpen:Void->Void;
	public var onPanelClose:Void->Void;
	
	public var interp:ScriptInterp;
	
	public function new() 
	{
		Debug.getIns();
		super();
		interp = new ScriptInterp();
		interp.variables.set("this", this);
		interp.variables.set("Debug", Debug);
		interp.variables.set("EventManager", EventManager);
		interp.variables.set("UniEvent", UniEvent);
		interp.variables.set("UIEvent", UIEvent);
		interp.variables.set("TypeInfo", TypeInfo);
		interp.variables.set("Uni", Uni);
		
		interp.variables.set("Text", Text);
		interp.variables.set("Image", Image);
		interp.variables.set("Button", Button);
		interp.variables.set("HBox", HBox);
		interp.variables.set("VBox", VBox);
	}
	
	public function sayHello():Void {
		trace("hello from ext:" + fullPath);
	}
	
	//to be deleted
	public function regFunc_afterInit(func:Dynamic->Void):Void {
		EventManager.getIns().addEventListener(EventManager.EXT_AFTER_INIT,func);
	}
	
	@:getter(panelInfo)
	public function get_panelInfo():PanelInfo {
		var panelInfo = ExtManager.getIns().mapPanelInfo[panelId];
		return panelInfo;
	}
	
	//return null if not opened
	@:getter(panel)
	public function get_panel():EditorPanel {
		var panelInfo = ExtManager.getIns().mapPanelInfo[panelId];
		if (panelInfo == null) return null;
		return EditorFrame.getIns().mapOpenPanels[panelInfo.id];
	}
	
	public function forceOpenPanel() {
		var panelInfo = ExtManager.getIns().mapPanelInfo[panelId];
		if (panelInfo == null) return;
		EditorFrame.getIns().openPanel(panelInfo);
	}
	
}