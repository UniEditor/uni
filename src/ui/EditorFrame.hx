package ui;
import editor.Debug;
import editor.extention.Extension;
import editor.extention.ExtManager;
import editor.render.StageRender;
import haxe.Constraints.Function;
import haxe.ui.toolkit.controls.Menu;
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
		for(one in ExtManager.getIns().cmdList){
			var cInfo:CmdInfo = ExtManager.getIns().mapCmdInfo[one];
			bindMenuItem(cInfo.id, cInfo, false, cInfo.path);
		}
		
		//bind built-in menu items with functions
		bindMenuItem("menu-Help-About", function(e:Dynamic) { } , true);
		
		addEventForAllMenuItems();
		
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
	private function onMenuItemClick(e:UIEvent) {
		trace("onMenuItemClick: " + e.component.id);
		
		var callBackItem:Dynamic = mapMenuInfo[e.component.id];
		if (callBackItem == null) {
			return;
		}
		
		trace(Type.typeof(callBackItem));
		
		if (Std.is(callBackItem, PanelInfo)) {
			var callBackPanelInfo:PanelInfo = cast callBackItem;
			if (callBackPanelInfo.isDialog == true) {
				//openfl dialong
				
				openPanel(callBackPanelInfo);//todo openDialog()
			}else {
				//open panel
				
				openPanel(callBackPanelInfo);
			}
		}else if (Std.is(callBackItem, CmdInfo)) {
			var callBackCmdInfo:CmdInfo = cast callBackItem;
			
			var ext:Extension = ExtManager.getIns().mapExt[callBackCmdInfo.extId];
			if (ext == null) { return; }
			
			ext.onCommandCall();
		}
		/*else if (Std.is(callBackItem,)) {
			
			callBackItem(e.component.id);
		}*/
		else {
			trace("ERROR: callback for" + e.component.id);
		}
	}
	
	
	//=====core functions=====	
	
	//path:should be File>Extension>file-ext-abc
	//sub menu id is its title
	
	//obj could: cmdInfo, panelInfo, String->Void
	public function bindMenuItem(id:String, obj:Dynamic, builtIn:Bool, ?menuPath:String) {
		trace("bindMenuItem:" + id + " ~ " + menuPath);
		
		mapMenuInfo.set(id, obj);
		
		if (builtIn == true) {
			return;
		}
		
		//create menu item for non-built-in
		
		var pathArray:Array<String> = menuPath.split(">");
		if (pathArray.length <= 1) {
			return;
		}
		
		var theRootMenu:Component = addRootMenuButton(pathArray[0]);
		
		pathArray.shift();
		addMenuItem(theRootMenu, pathArray, id);
	}
	
	private function addRootMenuButton(name:String):Component {
		
		var menubar:Component = getComponent("menubar");
		var theBtn:MenuButton = menubar.findChild("btn-"+name, null, true);
		if (theBtn == null) {
			trace("create new btn:" +name);
			theBtn = new MenuButton();
			theBtn.text = name;
			theBtn.id = "btn-"+name;
			menubar.addChild(theBtn);
		}
		
		//the btn will auto create menu if necessay
		
		return theBtn;
	}
	
	private function addMenuItem(container:Component, pathArray:Array<String>, id:String):Void {
		trace("addMenuItem id:" +id + " path:" + pathArray.join("-"));
		
		if (pathArray.length == 0) { return; }
		
		if (pathArray.length == 1) {
			//last one = item
			
			var curLevel:MenuItem = container.findChild(id);
			if (curLevel == null) {
				curLevel = new MenuItem();
				curLevel.text = pathArray[0];
				curLevel.id = id;
				//curLevel.addEventListener(UIEvent.CLICK, onMenuItemClick);
				container.addChild(curLevel);
			}
			
		}else {
			//folder
			trace("add folder:" +pathArray[0]);
			var curLevel:Menu = container.findChild("menu-"+pathArray[0]);
			if (curLevel == null) {
				trace("creating new:" + pathArray[0]);
				curLevel = new Menu();
				curLevel.text = pathArray[0];
				curLevel.id = "menu-"+pathArray[0];
				container.addChild(curLevel);
			}
			
			pathArray.shift();
			addMenuItem(curLevel, pathArray, id);
		}
	}
	
	public function addEventForAllMenuItems() {
		
		var menubar:Component = getComponent("menubar");
		for (one in menubar.children) {
			one.addEventListener(UIEvent.MENU_SELECT, onMenuItemClick);
		}
	}

	
}