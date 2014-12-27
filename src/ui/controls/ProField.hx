package ui.controls;


import data.EditableObject;
import data.pro.ProGroup;
import editor.event.EventManager;
import editor.event.UniEvent;
import editor.Uni;
import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.controls.Text;
import haxe.ui.toolkit.controls.TextInput;

/**
 * Has a label and input, binds data: proGroupName, proFieldName, will auto set value when change event happens
 * @author GDB
 */
class ProField extends HBox
{
	
	public var proName(default, set):String;
	private function set_proName(value:String):String {
		proName = value;
		render();
		return value;
	}
	
	public var fieldName(default, set):String;
	private function set_fieldName(value:String):String {
		fieldName = value;
		render();
		return value;
	}
	
	public var label_text(default, set):String;
	private function set_label_text(value:String):String {
		label_text = value;
		label.text = label_text;
		return value;
	}
	
	public var is_string(default, default):Bool;

	
	public var label:Text;
	public var input:TextInput;
	
	public function new() 
	{
		super();
		
		label = new Text();
		label.text = "Label";
		//label.width = 50;
		label.percentWidth = 50;
		label.height = 20;
		label.autoSize = false;
		addChild(label);
		
		input = new TextInput();
		input.text = "Label";		
		input.percentWidth = 50;
		input.height = 24;
		addChild(input);
		
		input.text = "0";
		input.onChange = input_onChange;
		
		EventManager.getIns().addEventListener(UniEvent.SEL_EB_OBJ_PRO_EDIT, render);
	}
	
	public function render(?e):Void {
		
		var edObj:EditableObject = Uni.getIns().mapEdObj[Uni.getIns().selectedId];
		if (edObj == null) return;
		
		var pro:ProGroup = edObj.get(proName);
		if (pro == null) return;
		
		input.text = Reflect.field(pro, fieldName);
	}
	
	private function input_onChange(e):Void {
		trace("input change");
		
		//trigger value change event on current selected
		
		//todo handle multi select
		var value:Dynamic = input.text;
		if (is_string == false) {
			value = Std.parseFloat(input.text);
		}
		
		trace("value:" + value);
		//./res/testProjectAsset//Chrysanthemum.jpg => 
		Uni.getIns().editEdObjPro(Uni.getIns().selectedId, proName, fieldName, value);
	}
	
	
}