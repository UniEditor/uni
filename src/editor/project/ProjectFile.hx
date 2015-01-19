package editor.project;
import data.lib.Asset;


/**
 * Stands for the project file itself, handles the file's save and load
 * Real functions should goto ProjectManager
 * @author GDB
 */
class ProjectFile
{
	
	public var projectPath:String;//base path
	
	//below is for serializing
	public var projectName:String;
	public var assetPath:String;
	public var lastOpenScene:String;//scene name
	
	public function new() 
	{
		
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
		
		if (projectXml.exists("project_name") == false) {
			trace("Error: Project dont have project_name");
			return;
		}
		
		if (projectXml.exists("asset_path") == false) {
			trace("Error: Project dont have asset_path");
			return;
		}
		
		if (projectXml.exists("last_open_scene") == false) {
			trace("Error: Project dont have last_open_scene");
			return;
		}
		
		projectName = projectXml.get("project_name");
		assetPath = projectXml.get("asset_path");
		lastOpenScene = projectXml.get("last_open_scene");
	}
	
}