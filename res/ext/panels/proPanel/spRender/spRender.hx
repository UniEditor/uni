//this file is loaded by proPanel.hx at runtime
//this file contains code for render spRender property subpanel

function renderFunc(uiBody, proGroup) {
	
	var listSel = uiBody.findChild("listSel", null, true);
	
	trace(listSel.dataSource);
	
	function onChange_listSel(e) {
		trace("onChange_listSel", e);
		trace(listSel.selectedIndex);
	}
	
	listSel.onChange = onChange_listSel;
	
	
}
renderFuncMap.set("spRender", renderFunc);