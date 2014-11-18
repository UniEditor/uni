package script;
import hscript.Parser;
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
	
	public var interp:Interp;
	public var parser:Parser;
	
	public function new() 
	{
		parser = new Parser();
		interp = new Interp();
	}
	
	public function runString(script:String, ?customInterp:Interp) {
		var program = parser.parseString(script);
		if(customInterp != null)
			customInterp.execute(program);
		else {
			interp.execute(program);
		}
	}
	
	
	
}