package editor;
import data.EditableObject;
import editor.Uni.Nest;
import haxe.remoting.AMFConnection;

/**
 * Manages data, not ui frames
 * @author GDB
 */
class Uni
{
	
	//singleton
	public static var instance:ExtManager;
	public static function getIns():ExtManager {
		if (instance == null) {
			instance = new ExtManager();
		}
		return instance;
	}
	
	
	
	//holds data for everything
	//lib (symbols, assets)
	//stage object tree
	
	public var mapEdObj:Map<String, EditableObject>;
	public var nestEdObj:Nest;
	
	
	public function new() 
	{
		mapEdObj = new Map<String, EditableObject>();
		nestEdObj = new Nest();
	}
	
	
	public function createEmptyEdObj():Void {
		
		
		
		
	}
	
	
	
}

class Nest {
	
	public var id:String;
	public var data:Dynamic;
	public var child:Array<Nest>;
	
	public function new() {
		child = new Array<Nest>();
	}
}