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
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.core.XMLController;
import haxe.ui.toolkit.events.UIEvent;
import haxe.ui.toolkit.hscript.ScriptInterp;
import hscript.Interp;
import modules.basic.ProTransform;
import sys.io.File;
import openfl.events.EventDispatcher;
import sys.io.FileOutput;
import systools.Dialogs;
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
		interp.variables.set("File", File);
		interp.variables.set("Xml", Xml);
		interp.variables.set("Toolkit", Toolkit);
		interp.variables.set("Dialogs", Dialogs);
		interp.variables.set("Std", Std);
		
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
	
	public function genXML():String {
		//var path = Dialogs.saveFile("Export", "Please select dir to export:", "./");
		
		var xmlDoc = Xml.createElement("data");
		var xmlStageData = Xml.createElement("stageData");
		xmlDoc.addChild(xmlStageData);
		
		for (one in Uni.getIns().mapEdObj) {
			var oneXml = Xml.createElement("obj");
			oneXml.set("type", one.typeInfoID);
			oneXml.set("id", one.id);
			
			var transform:ProTransform = cast one.get("transform");
			oneXml.set("x", ""+transform.x);
			oneXml.set("y", ""+transform.y);			
			xmlStageData.addChild(oneXml);
		}
		
		return xmlDoc.toString();
	}
	
	public function saveStringToPath(path:String, content:String):Void {
		var f:FileOutput = File.write(path);
		f.writeString(content);
		f.close();
	}
	
	public function strToInt(str:String):Int {
		return Std.parseInt(str);
	}
}