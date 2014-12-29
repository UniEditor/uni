package script;

/**
 * ...
 * @author GDB
 */
class Table
{
	
	var theMap:Map<String, Dynamic>;
	
	public function new() 
	{
		theMap = new Map<String, Dynamic>();
	}
	
	public function set(key:String, value:Dynamic):Void {
		if (value == null) {
			theMap.remove(key);
			return;
		}
		theMap[key] = value;
	}
	
	public function get(key:String):Dynamic {
		return theMap.get(key);
	}
	
	public function size():Int {
		var count:Int = 0;
		for (one in theMap.keys()) {
			count++;
		}
		return count;
	}
	
}