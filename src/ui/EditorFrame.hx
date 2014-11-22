package ui;
import editor.Debug;
import editor.extention.Extension;
import editor.extention.ExtManager;
import editor.render.StageRender;
import haxe.ui.toolkit.controls.MenuItem;
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
	
	public var mapOpenPanels:Map<String, EditorPanel>;
	
	public function new() 
	{
		super("ui/main.xml");
		mapOpenPanels = new Map<String, EditorPanel>();
		
		//create stageRender
		addChild(StageRender.getIns());
	}
	
	//interfaces
	public function openPanel(panelInfo:PanelInfo):Void {
		trace("openPanel "+panelInfo.id);
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
		trace("closePanel " + edPanel.panelid);
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
	
	private function onMenuItemClick_Panel(e:UIEvent) {
		trace("onMenuItemClick_Panel: "+e);

		var panelID:String = e.component.id;
		if (panelID == null) { return; }
		
		var panelInfo:PanelInfo = ExtManager.getIns().mapPanelInfo[panelID];
		if (panelInfo == null) { return; }
		
		//create panel
		openPanel(panelInfo);
	}
	
	public function updateExtSubMenu() {
		
		//panels
		for(one in ExtManager.getIns().panelList){
			
			var pInfo:PanelInfo = ExtManager.getIns().mapPanelInfo[one];
			var menuitem:MenuItem = new MenuItem();
			menuitem.text = pInfo.title;
			menuitem.id = pInfo.id;
			menuitem.addEventListener(UIEvent.CLICK, onMenuItemClick_Panel);
			
			//menu-ext
			var menu_ext = getComponent("menu-ext");
			menu_ext.addChild(menuitem);
		}
	}
	
	
}