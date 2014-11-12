package editor.extention ;
import haxe.ds.Vector;
import sys.FileSystem;

/**
 * ...
 * @author GDB
 */
class ExtManager
{
	
	//singleton
	
	public function new() 
	{
	}
	
	//
	public var mapExt:Array<Extension>;
	
	public function loadExts():Void {
		//recursively find in res folder
		
		//yet mark those in commnads, expoerters and extensions folder and panels
		
		
		
		Array<String> res = FileSystem.readDirectory("/res");
		
		
		
		
		
	}
	
	public function initExts():Void {
		
	}
	
	public function updateExts():Void {
		
	}
	
}