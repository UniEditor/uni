package ui.controls;


import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.controls.Text;
import haxe.ui.toolkit.controls.TextInput;

/**
 * Has a label and input, has data: proGroupName, proFieldName, will auto set value when change event happens
 * @author GDB
 */
class ProField extends HBox
{
	
	
	public var bind_proName(get, set):String;
	
	private var _bind_proName:String;
	private function set_bind_proName(value:String):String {
		_bind_proName = value; trace("GOT set" + value);
		return value;
	}
	private function get_bind_proName():String {
		return _bind_proName; trace("GOT get");
	}
	
	public var bind_fieldName:String;
	
	
	
	public var label:Text;
	public var input:TextInput;
	
	public function new() 
	{
		super();
		
		label = new Text();
		label.text = "Label";
		addChild(label);
		
		input = new TextInput();
		input.text = "Label";
		addChild(input);
	}
	
	
	
	
}