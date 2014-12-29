this.id = "uni.pro";

this.onInit = function(){
	this.forceOpenPanel();
}

var groupList = [];
var renderFuncMap = new Table();

//this.interp.variables.set("renderFuncMap", renderFuncMap);



function renderEdObj(edObj) {
	trace("PRO_PANEL: renderEdObj("+edObj.id+")");
	
	var body = this.get_panel().body;
	var header = body.findChild("header", null, true);
	var txt_name = body.findChild("txt_name", null, true);
	var txt_type = body.findChild("txt_type", null, true);
	var content = body.findChild("content", null, true);
	
	txt_name.text = edObj.id;
	txt_type.text = edObj.typeInfoID;
	
	var totalHt = 20;//panel header
	var headerHt = header.height;
	trace("headerHt " + headerHt);
	totalHt += headerHt;
	
	for (one in groupList) {
		content.removeChild(one);
	}
	
	groupList = [];
	
	for (one in edObj.proGroupList) {
		trace(one);
		
		var xmlPath = this.folderPath + "/" + one+"/" + one+".xml";
		if (this.isFileExist(xmlPath)) {
			
			var proGroupData = edObj.proGroups.get(one);
			var file =this.getFileContent(xmlPath);
			var xml = Xml.parse(file);
			var bodyXml = this.getXmlFirstChildOfName(xml, "proDefine");
			var minHtStr = bodyXml.get("minHt");
			
			totalHt += Std.parseInt(minHtStr);
			totalHt += 20;//group header
			
			
			var body = Toolkit.processXml(bodyXml);
			var group_frame = new ProFrame();
			group_frame.setTitle(proGroupData.displayName);
			group_frame.addContent(body);
			content.addChild(group_frame);
			group_frame.height = Std.parseInt(minHtStr) + 40;
			
			//var sub_content = group_frame.findChild("sub_content", null, true);
			//sub_content.addChild(body);
			groupList.push(group_frame);
			
			var hxPath = this.folderPath + "/" + one +"/" + one+".hx";
			if (this.isFileExist(hxPath)) {
				var file2 = this.getFileContent(hxPath);
				ScriptManager.getIns().runString(file2, this.interp);
				
				var theRenderFunc = renderFuncMap.get(one);
				if (theRenderFunc != null ) {
					
					theRenderFunc("12", "34");
				}
				
			}
		}
	}
	
	trace(totalHt);
	//this.get_panel().height = totalHt;
	
	trace("PRO_PANEL: renderEdObj DONE");
}

function renderNull() {
	var body = this.get_panel().body;
	
	var txt_name = body.findChild("txt_name", null, true);
	txt_name.text = "Null";
	
	var txt_type = body.findChild("txt_type", null, true);
	txt_type.text = "Null";
	
	var content = body.findChild("content", null, true);
	
	for (one in groupList) {
		//trace("remove one");
		content.removeChild(one);
	}
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



