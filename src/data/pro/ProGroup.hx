package data.pro;

/**
 * Progroups is just like the components in Unity
 * Put modulized properties in a group, to be reused and provides a way for properties panels to organise
 * Each editorObj might have various ProGroups, like Transformatin, Render, UILayout	
 * @author 
 */
class ProGroup
{
	
	public var displayName:String;
	public var fields:Array<ProField>;
	
	public function new() 
	{
		fields = new Array<ProField>();
	}
	
	public function printSelf():String {
		var res:String = "";
		
		for (one in fields) {
			var value:Dynamic = Reflect.getProperty(this, one.name);
			res += one.name+"=>" + value+"\n";
		}
		
		return res;
	}
}

class ProField
{
	
	public var name:String;
	public var type:String;//N F S
	public var value:Dynamic;
	
	public function new(name_:String, type_:String) 
	{
		name = name_;
		type = type_;
	}
}