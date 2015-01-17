package modules.uniSprite ;
import data.EdObject;
import data.pro.ProGroup;
import modules.basic.ProTransform;

/**
 * So this is the pure data, not render
 * @author 
 */
class UniSprite extends EdObject
{
	
	//pros:
	//transformation
	//typeinfo
	//render
	//custome infomation
	
	public var transform:ProTransform;
	public var spRender:ProSpRender;
	
	public function new() 
	{
		super();
		
		proGroupList.push("transform");
		proGroups["transform"] = new ProTransform();
		transform = cast proGroups["transform"];
		
		proGroupList.push("spRender");
		proGroups["spRender"] = new ProSpRender();
		spRender = cast proGroups["spRender"];
		
		renderClass = UniSpriteRender;
	}
	
	
	
}