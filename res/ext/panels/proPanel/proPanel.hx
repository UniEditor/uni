
this.id = "uni.pro";

this.onInit = function(){
	
}


function renderEdObj(edObj) {
	trace("start renderEdObj");
	
	var body = this.get_panel().body;
	trace("body" + body);
	
	var txt_name = body.findChild("txt_name", null, true);
	txt_name.text = edObj.id;
	
	var txt_type = body.findChild("txt_type", null, true);
	txt_type.text = edObj.typeInfoID;
	
	var content = body.findChild("content", null, true);
	
	for (one in edObj.proGroupList) {
		trace(one);
		
		if (one == "transform") {
			trace(this.folderPath + "/transform/transform.xml");
			trace(File);
			var file =this.getFileContent(this.folderPath + "/transform/transform.xml");
			//trace(file);
			
			var xml = Xml.parse(file);
			//trace(xml);
			
			var bodyXml = this.getXmlFirstChildOfName(xml, "proDefine");
			trace(bodyXml);
			
			var body = Toolkit.processXml(bodyXml);
			trace("body" + body);
			
			var frame = Toolkit.processXmlResource("ui/panels/pro_frame.xml");
			content.addChild(frame);
			
			var sub_content = frame.findChild("sub_content", null, true);
			sub_content.addChild(body);
		}
	}
	
}

function renderNull() {
	var body = this.get_panel().body;
	
	var txt_name = body.findChild("txt_name", null, true);
	txt_name.text = "Null";
	
	var txt_type = body.findChild("txt_type", null, true);
	txt_type.text = "Null";
}

//main devider functions
function render() {
	trace("render start");
	
	var panel = this.get_panel();
	if (panel == null) return;
	
	var body = this.get_panel().body;
	if (body == null) return;
	
	var edObjID = Uni.getIns().selectedId;
	trace("edObjID: " + edObjID);
	
	if (edObjID == null) {
		renderNull();
		return;
	}
	
	var edObj = Uni.getIns().mapEdObj.get(edObjID);
	//trace("mapEdObj: " + Uni.getIns().mapEdObj.toString());
	trace("edObj: " + edObj);
	if (edObj == null) {
		renderNull();
		return;
	}
	
	renderEdObj(edObj);
}

function onSelectChange(e) {
	trace("uni pro on select change");
	render();
}

EventManager.getIns().addEventListener(UniEvent.SEL_CHANGE, onSelectChange);


this.onPanelOpen = function(){
	render();
}

this.onPanelClose = function(){
	
}



