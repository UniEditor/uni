package utils;
import haxe.ui.toolkit.core.DisplayObjectContainer;

/**
 * ...
 * @author GDB
 */
class Utils
{

	public function new() 
	{
		
	}
	
	public static function printDisplayList(disCon:DisplayObjectContainer):String {
		
		var res:String = "";
		for (child in disCon.children) {
			res += "child";
		}
		
		
		
	}
	
}