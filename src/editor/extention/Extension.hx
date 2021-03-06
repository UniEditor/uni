package editor.extention;
import data.TypeInfo;
import editor.Debug;
import editor.event.EventManager;
import editor.event.UniEvent;
import editor.extention.ExtManager.PanelInfo;
import editor.project.ProjectManager;
import editor.project.SceneFile;
import editor.Uni;
import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.Image;
import haxe.ui.toolkit.controls.Text;
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.core.XMLController;
import haxe.ui.toolkit.events.UIEvent;
import haxe.ui.toolkit.hscript.ScriptInterp;
import script.ScriptManager;
import hscript.Interp;
import modules.basic.ProTransform;
import script.Table;
import script.UniInterp;
import sys.FileSystem;
import sys.io.File;
import openfl.events.EventDispatcher;
import sys.io.FileOutput;
import systools.Dialogs;
import ui.controls.ProFrame;
import ui.EditorFrame;
import ui.EditorPanel;

/**
 * ...
 * @author GDB
 */
class Extension extends EventDispatcher
{
	
	public var id:String;
	
	public var folderPath:String;
	public var fullPath:String;
	public var panelId:String;
	public var exporterId:String;
	
	//function to override in script
	public var onInit:Void->Void;
	public var onPanelOpen:Void->Void;
	public var onPanelClose:Void->Void;
	public var onCommandCall:Void->Void;
	
	public var interp:UniInterp;
	
	public function new() 
	{
		Debug.getIns();
		super();
		
		interp = new UniInterp();
		interp.variables.set("this", this);
		interp.variables.set("Debug", Debug);
		
		interp.variables.set("Uni", Uni);
		interp.variables.set("EventManager", EventManager);
		interp.variables.set("ScriptManager", ScriptManager);
		interp.variables.set("ProjectManager", ProjectManager);
		interp.variables.set("UniEvent", UniEvent);
		interp.variables.set("TypeInfo", TypeInfo);
		interp.variables.set("SceneFile", SceneFile);
		interp.variables.set("Xml", Xml);
		
		//system
		interp.variables.set("File", File);
		interp.variables.set("Dialogs", Dialogs);
		interp.variables.set("Std", Std);
		
		//ui
		interp.variables.set("Toolkit", Toolkit);
		interp.variables.set("Text", Text);
		interp.variables.set("Image", Image);
		interp.variables.set("Button", Button);
		interp.variables.set("HBox", HBox);
		interp.variables.set("VBox", VBox);
		interp.variables.set("Table", Table);
		interp.variables.set("UIEvent", UIEvent);
		
		interp.variables.set("ProFrame", ProFrame);
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
	
	//in use
	public function forceOpenPanel() {
		trace("try forceOpenPanel: " + panelId);
		var panelInfo = ExtManager.getIns().mapPanelInfo[panelId];
		if (panelInfo == null) return;
		EditorFrame.getIns().openPanel(panelInfo);
	}
	
	public function getFileContent(path:String):String {
		var file = File.getContent(path);
		return file;
	}
	
	public function getXmlFirstChildOfName(xml:Xml, name:String):Xml {
		trace("getXmlFirstChildOfName: " + name);
		for (sec in xml.elementsNamed(name) ) {
			return sec;
		}
		return null;
	}
	
	public function createXML(name:String):Xml {
		return Xml.createElement(name);
	}
	
	public function saveStringToPath(path:String, content:String):Void {
		var f:FileOutput = File.write(path);
		f.writeString(content);
		f.close();
	}
	
	public function strToInt(str:String):Int {
		return Std.parseInt(str);
	}
	
	//in use
	public function isFileExist(str:String):Bool {
		return FileSystem.exists(str);
	}
}