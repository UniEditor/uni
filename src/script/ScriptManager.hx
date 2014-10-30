package script;
import haxe.xml.Parser;
import hscript.Interp;

/**
 * ...
 * @author GDB
 */
class ScriptManager
{
	
	public static var instance:ScriptManager;
	public static function getIns():ScriptManager {
		if (instance == null) {
			instance = new ScriptManager();
		}
		return instance;
	}
	
	
	
	public var parser:Parser;
	public var interp:Interp;
	
	public function new() 
	{
		parser = new Parser();
		interp = new Interp();
	}
	
	public function runString(script:String) {
		var program = parser.parseString(script);
		interp.execute(program);
	}
	
	
	
}