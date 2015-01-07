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
		
		
		
		
	}
	
	public function load(data:String):Void {
		
		var xml:Xml = Xml.parse(data);
		
		
		
		
	}
	
}