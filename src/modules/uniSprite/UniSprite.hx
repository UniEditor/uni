package modules.uniSprite ;
import data.EditableObject;
import data.pro.ProGroup;
import modules.basic.ProGroupTransformation;

/**
 * So this is the pure data, not render
 * @author 
 */
class UniSprite extends EditableObject
{
	
	//pros:
	//transformation
	//typeinfo
	//render
	//custome infomation
	
	public var transform:ProGroupTransformation;
	
	public function new() 
	{
		super();
		proGroups["transform"] = new ProGroupTransformation();
		transform = cast proGroups["transform"];
		
		renderClass = UniSpriteRender;
	}
	
	
	
}