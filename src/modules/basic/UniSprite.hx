package modules.basic;
import data.EditableObject;
import data.pro.ProGroup;

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
	
	public function new() 
	{
		super();
		proGroups.push(new ProGroupTransformation());
	}
	
	@:getter(transformation)
	public function get_transformation() {
		return null;
	}
	
}