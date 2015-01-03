package ui;
import editor.Debug;
import editor.extention.Extension;
import editor.extention.ExtManager;
import editor.render.StageRender;
import haxe.ui.toolkit.controls.MenuButton;
import haxe.ui.toolkit.controls.MenuItem;
import haxe.ui.toolkit.core.Component;
import haxe.ui.toolkit.core.PopupManager;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.core.XMLController;
import haxe.ui.toolkit.events.MenuEvent;
import haxe.ui.toolkit.events.UIEvent;
import openfl.events.MouseEvent;

/**
 * Helds everythings, menu bar, all panels, and stage
 * @author GDB
 */
class EditorFrame extends XMLController
{
	
	public static var instance:EditorFrame;
	public static function getIns():EditorFrame {
		if (instance == null) {
			instance = new EditorFrame();
		}
		return instance;
	}
	
	public var mainBox:Component;
	public var mapOpenPanels:Map<String, EditorPanel>;
	public var mapMenuInfo:Map<String, Dynamic>;
	
	public function new() 
	{
		super("ui/main.xml");
		mapOpenPanels = new Map<String, EditorPanel>();
		mapMenuInfo = new Map<String, Dynamic>();
		
		//create stageRender
		mainBox = this.getComponent("mainBox");
	}
	
	public function init():Void {
		
		//create menu items for panels, cmds, dialogs
		
		//panels
		for(one in ExtManager.getIns().panelList){
			var pInfo:PanelInfo = ExtManager.getIns().mapPanelInfo[one];
			bindMenuItem(pInfo.id, pInfo, false, pInfo.path);
		}
		
		//commands
		var menu_ext = getComponent("menu-ext");
		for(one in ExtManager.getIns().cmdList){
			var cInfo:CmdInfo = ExtManager.getIns().mapCmdInfo[one];
			bindMenuItem(cInfo.id, cInfo, false, cInfo.path);
		}
		
		//bind built-in menu items with functions
		
		
		
	}
	
	//=====interfaces for script=====
	
	public function openPanel(panelInfo:PanelInfo):Void {
		//trace("openPanel "+panelInfo.id);
		Debug.getIns().log("openPanel " + panelInfo.id);
		
		if (mapOpenPanels.exists(panelInfo.id)) {
			var thePanel:EditorPanel = mapOpenPanels[panelInfo.id];
			root.addChild(thePanel);//readd to put at top
			
		}else {
			//creating new
			var panel:EditorPanel = new EditorPanel();
			panel.init(panelInfo);
			root.addChild(panel);	
			mapOpenPanels[panelInfo.id] = panel;
			
			//call panel open
			if (panelInfo.extId != null && panelInfo.extId != "") { 
				var ext:Extension = ExtManager.getIns().mapExt[panelInfo.extId];
				if (ext != null && ext.onPanelOpen != null) {
					ext.onPanelOpen();
				}
			}
		}
	}
	
	public function closePanel(edPanel:EditorPanel):Void {
		//trace("closePanel " + edPanel.panelid);
		Debug.getIns().log("closePanel " + edPanel.panelid);
		
		if (mapOpenPanels.exists(edPanel.panelid)) {
			mapOpenPanels.remove(edPanel.panelid);
			root.removeChild(edPanel);
			
			var panelInfo:PanelInfo = ExtManager.getIns().mapPanelInfo[edPanel.panelid];
			if(panelInfo != null){
				//call panel open
				if (panelInfo.extId != null && panelInfo.extId != "") {
					var ext:Extension = ExtManager.getIns().mapExt[panelInfo.extId];
					if (ext != null && ext.onPanelClose != null) {
						ext.onPanelClose();
					}
				}
			}
		}
	}
	
	//=====UI Event Handles=====
	private function onMenuItemClick_Panel(e:UIEvent) {
		trace("onMenuItemClick_Panel: "+e);

		var panelID:String = e.component.id;
		if (panelID == null) { return; }
		
		var panelInfo:PanelInfo = ExtManager.getIns().mapPanelInfo[panelID];
		if (panelInfo == null) { return; }
		
		//create panel
		openPanel(panelInfo);
	}
	
	private function onMenuItemClick_Exporter(e:UIEvent) {
		trace("onMenuItemClick_Exporter: "+e);
		
		var panelID:String = e.component.id;
		if (panelID == null) { return; }
		
		var panelInfo:PanelInfo = ExtManager.getIns().mapPanelInfo[panelID];
		if (panelInfo == null) { return; }
		
		//create panel
		openPanel(panelInfo);
	}
	
	private function onMenuItemClick_Cmd(e:UIEvent) {
		trace("onMenuItemClick_Cmd: "+e);
		
		var cmdID:String = e.component.id;
		if (cmdID == null) { return; }
		
		var cmdInfo:CmdInfo = ExtManager.getIns().mapCmdInfo[cmdID];
		if (cmdInfo == null) { return; }
		
		var ext:Extension = ExtManager.getIns().mapExt[cmdInfo.extId];
		if (ext == null) { return; }
		
		ext.onCommandCall();
	}
	
	private function onMenuItemClick(e:UIEvent) {
		trace("onMenuItemClick: " + e.component.id);
		
		
		
	}
	
	
	//=====core functions=====	
	
	//path:should be File>Extension>file-ext-abc
	//sub menu id is its title
	
	//obj could: cmdInfo, panelInfo, String->Void
	public function bindMenuItem(id:String, obj:Dynamic, builtIn:Bool, menuPath:String) {
		
		mapMenuInfo.set(id, obj);
		
		if (builtIn == true) {
			return;
		}
		
		//create menu item for non-built-in
		
		var pathArray:Array<String> = menuPath.split(">");
		if (pathArray.length <= 0) {
			return;
		}
		
		var curLevel:Component = getComponent(pathArray[0]);
		var hbox:Component = getComponent("menubar");
		if (curLevel == null) {
			curLevel = new MenuButton();
			curLevel.text = pathArray[0];
			curLevel.id = pathArray[0];
			curLevel.addEventListener(UIEvent.CLICK, onMenuItemClick);
			hbox.addChild(curLevel);
		}
		
		pathArray.shift();
		addMenuItem(curLevel, pathArray);
	}
	
	private function addMenuItem(container:Component, pathArray:Array<String>):Void {
		
		if (pathArray.length == 0) { return; }
		
		var curLevel:Component = container.findChild(pathArray[0]);
		if (curLevel == null) {
			curLevel = new MenuItem();
			curLevel.text = pathArray[0];
			curLevel.id = pathArray[0];
			curLevel.addEventListener(UIEvent.CLICK, onMenuItemClick);
			container.addChild(curLevel);
		}
		
		pathArray.shift();
		addMenuItem(curLevel, pathArray);
	}
	
	public function addEventForAllMenuItems() {
		
		
		
	}

	
}