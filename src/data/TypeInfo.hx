package data;
import data.pro.ProGroup;

/**
 * ...
 * @author 
 */
class TypeInfo
{
	
	//hard data: not to be changed once loaded
	public var name:String;
	public var reflect:String;
	public var icon:String;
	
	//soft data: to be edited by user
	public var customPro:ProGroup;
	
	public var final:Bool;//non-final types are extensible
	
	public function new() 
	{
		
	}
	
}