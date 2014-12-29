
trace("from spRender.hx");
trace("renderFuncMap"+renderFuncMap);

function renderFunc(a, b) {
	trace("a" + a);
	trace("b" + b);
}

renderFuncMap.set("spRender", renderFunc);