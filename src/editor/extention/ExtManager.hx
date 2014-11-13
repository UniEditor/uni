package editor.extention ;
import haxe.ds.Vector;
import openfl.net.URLRequest;
import script.ScriptManager;
import sys.FileSystem;
import sys.io.File;

/**
 * ...
 * @author GDB
 */
class ExtManager
{
	
	//singleton
	public static var instance:ExtManager;
	public static function getIns():ExtManager {
		if (instance == null) {
			instance = new ExtManager();
		}
		return instance;
	}
	
	
	public function new() 
	{
	}
	
	//
	public var mapExt:Array<Extension>;
	
	public function loadExts():Void {
		//recursively find in res folder
		
		//yet mark those in commnads, expoerters and extensions folder and panels
		
		var basePath = "./res/";
		
		loadExtFromFolder(basePath);
		
	}
	
	public function loadExtFromFolder(fullPath:String) {
		
		var res:Array<String> = FileSystem.readDirectory(fullPath);
		if (res != null) {
			for (s in res) {
				var childItemPath:String = fullPath + "/" + s;
				var isFolder:Bool = FileSystem.isDirectory(childItemPath); 
				
				if (isFolder == true) {
					loadExtFromFolder(childItemPath);
				}else {
					if (getEndfix(s) == "hs") {
						trace("got hs file: " + childItemPath);
						
						var content:String = File.getContent(childItemPath);
						trace("content:" + content);
						ScriptManager.getIns().runString(content);
						
					}
				}
			}
		}
	}
	
	public function initExts():Void {
		
	}
	
	public function updateExts():Void {
		
	}
	
	public function getEndfix(path:String):String {
		//trace("getEndfix 1 " + path);
		var lastDot:Int = path.lastIndexOf(".");
		if(lastDot >= 0){
			var endFix:String = path.substr(lastDot + 1);
			return endFix;
		}
		
		return "";
	}
	
}