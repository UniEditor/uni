package ui;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.XMLController;

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
}