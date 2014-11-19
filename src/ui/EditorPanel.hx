package ui;
import editor.extention.ExtManager.PanelInfo;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.core.Component;
import haxe.ui.toolkit.core.interfaces.IDraggable;
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.events.UIEvent;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

/**
 * ...
 * @author GDB
 */
class EditorPanel extends Component implements IDraggable
{
	
	public var body:Component;
	public var panelid:String;
	
	public function new() 
	{
		super();
	}
	
	public function init(panelInfo:PanelInfo):Void {
		trace("panel init " + panelInfo.id);
		panelid = panelInfo.id;
		
		var frame:Component = Toolkit.processXmlResource("ui/panels/panel_frame.xml");
		//trace(frame);
		addChild(frame);
		
		frame.width = 200;
		frame.height = 200;
		
		//var main:Component = frame.findChild("main");
		var headerBar:Component = frame.findChild("headerBar", null, true);
		//trace(headerBar);
		
		//set title
		var header_title = headerBar.findChild("header_title");
		//trace(header_title);
		header_title.text = panelInfo.title;
		
		//set icon
		//todo
		
		//close btn
		var btn_close:Component = headerBar.findChild("btn_close");
		btn_close.addEventListener(UIEvent.CLICK, onBtnClick_close);
		
		//set body
		//trace(panelInfo.body);
		if(panelInfo.body != null){
			body = Toolkit.processXml(panelInfo.body);
			
			var content:Component = frame.findChild("content", null, true);
			content.addChild(body);
		}
	}
	
	public function onBtnClick_close(e) {
		trace("onBtnClick_close: " + this);
		EditorFrame.getIns().closePanel(this);
	}
	
	public function allowDrag(event:MouseEvent):Bool {
		return true;
	}
}