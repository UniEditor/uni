package ui.controls;

import haxe.ui.toolkit.containers.ContinuousHBox;
import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.controls.Text;
import haxe.ui.toolkit.core.Component;

/**
 * ...
 * @author GDB
 */
class ProFrame extends VBox
{
	
	var bar:HBox;
	var barTitle:Text;
	var subContainer:VBox;
	
	public function new() 
	{
		super();
		
		bar = new HBox();
		bar.height = 40;
		bar.style.backgroundColor = 0x3A3A3A;
		addChild(bar);
		
		barTitle = new Text();
		barTitle.style.color = 0xDBDBDB;
		bar.addChild(barTitle);
		
		subContainer = new VBox();
		addChild(subContainer);
	}
	
	public function setTitle(str:String):Void {
		barTitle.text = str;
	}
	public function addContent(obj:Component):Void {
		subContainer:addChild(obj)
	}
	
}