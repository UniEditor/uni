package utils;
import haxe.ui.toolkit.core.Component;
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
	
	public static function getEndfix(path:String):String {
		//trace("getEndfix 1 " + path);
		var lastDot:Int = path.lastIndexOf(".");
		if(lastDot >= 0){
			var endFix:String = path.substr(lastDot + 1);
			return endFix;
		}
		return "";
	}
	
	public static function printDisplayList(disCon:DisplayObjectContainer):String {
		
		var res:String = "";
		for (child in disCon.children) {
			res += "child";
		}
		
		return res;
	}

	
}