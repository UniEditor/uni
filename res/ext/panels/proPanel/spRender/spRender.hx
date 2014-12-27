//this file is loaded by proPanel.hx at runtime
//this file contains code for render spRender property subpanel

function renderFunc(uiBody, proGroup) {
	
	var listSel = uiBody.findChild("listSel", null, true);
	
	var page_rect = uiBody.findChild("page_rect", null, true);
	var page_image = uiBody.findChild("page_image", null, true);
	
	//render
	function renderStuff() {
		var newValue = proGroup.renderType;
		if (newValue == "image") {
			page_rect.visible = false;
			page_image.visible = true;
		}else {
			page_rect.visible = true;
			page_image.visible = false;
		}
	}
	
	function init() {
		var newValue = proGroup.renderType;
		if (newValue == "image") {
			listSel.selectedIndex = 1;
		}else {
			listSel.selectedIndex = 0;
		}
	}
	
	//ui event
	
	trace(listSel.dataSource);
	
	function onChange_listSel(e) {
		trace("onChange_listSel", e);
		trace(listSel.selectedIndex);
		
		var newValue = "rect";
		if (listSel.selectedIndex == 1) {
			newValue = "image";
		}
		
		Uni.getIns().editEdObjPro( Uni.getIns().selectedId, "spRender", "renderType", newValue);
	}
	listSel.onChange = onChange_listSel;
	
	init();
	renderStuff();
	
	EventManager.getIns().addEventListener(UniEvent.SEL_EB_OBJ_PRO_EDIT, renderStuff);
}
renderFuncMap.set("spRender", renderFunc);