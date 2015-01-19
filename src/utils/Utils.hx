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
	
	public static function isUnderPath(childPath:String, basePath:String):Bool {
		
		var ind:Int = childPath.indexOf(basePath);
		if (ind == 0 && childPath.length > basePath.length) {
			return true;
		}
		
		return false;
	}
	
	public static function printDisplayList(disCon:DisplayObjectContainer):String {
		
		var res:String = "";
		for (child in disCon.children) {
			res += "child";
		}
		
		return res;
	}
	
	public static function getMapCount(map:Map<Dynamic, Dynamic>):Int {
		var count:Int = 0;
		for (one in map) {
			count++;
		}
		return count;
	}

	public static function getBasePath(fullpath:String):String {
		//trace("getEndfix 1 " + path);
		var lastSlash:Int = fullpath.lastIndexOf("/");
		if(lastSlash >= 0){
			var base:String = fullpath.substr(0, lastSlash);
			return base;
		}
		return fullpath;
	}
	
	public static function toForwardSlash(path:String):String {
		if (path.indexOf("\\") > 0 ) {
			var segs:Array<String> = path.split("\\");
			return segs.join("/");
		}
		return path;
	}
	
}