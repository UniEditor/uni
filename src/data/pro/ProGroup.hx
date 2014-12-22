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
}

class ProField
{
	
	public var name:String;
	public var type:String;
	public var value:Dynamic;
	
}