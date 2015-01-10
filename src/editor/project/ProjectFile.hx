package editor.project;


/**
 * Data for Project
 * @author GDB
 */
class ProjectFile
{
	
	public var projectName:String;
	public var projectPath:String;
	public var assetPath:String;
	
	public var sceneList:Array<SceneFile>;
	
	public function new() 
	{
		sceneList = new Array<SceneFile>();
	}
	
	public function saveToFile():String {
		
		var xml:Xml = Xml.createDocument();
		
		
		var child1:Xml = Xml.createElement("projectName");
		child1.nodeValue = projectName;
		xml.addChild(child1);
		 
		var child2:Xml = Xml.createElement("projectPath");
		child2.nodeValue = projectPath;
		xml.addChild(child2);
		
		var child3:Xml = Xml.createElement("assetPath");
		child3.nodeValue = assetPath;
		xml.addChild(child3);
		
		return xml.toString();
	}
	
	public function load(data:String):Void {
		
		var root:Xml = Xml.parse(data);
		
		var projectXml:Xml;
		for (one in root.elementsNamed("project")) {
			projectXml = one;
			break;
		}
		
		trace(projectXml.get("project_name"));
	}
	
}