package ui;
import editor.extention.ExtManager;
import haxe.ui.toolkit.controls.MenuItem;
import haxe.ui.toolkit.core.Root;
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
	
	public function new() 
	{
		super("ui/main.xml");
	}
	
	
	private function onMenuItemClick_Panel(e:UIEvent) {
		trace("onMenuItemClick_Panel: "+e);

		var panelID:String = e.component.id;
		if (panelID == null) { return; }
		
		var panelInfo:PanelInfo = ExtManager.getIns().mapPanelInfo[panelID];
		if (panelInfo == null) { return; }
		
		//create panel
		var panel:EditorPanel = new EditorPanel();
		root.addChild(panel);
		
		
		
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