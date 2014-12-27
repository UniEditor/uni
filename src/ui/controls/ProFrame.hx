package ui.controls;

import haxe.ui.toolkit.containers.ContinuousHBox;
import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.controls.Text;

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
		addChild(bar);
		
		barTitle = new Text();
		bar.addChild(barTitle);
		
		subContainer = new VBox();
		addChild(subContainer);
	}
	
	public function setTitle(str:String):Void {
		barTitle.text = str;
	}
}