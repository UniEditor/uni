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
	
}