package hxga;

class EventParams extends BaseParams, implements IParamsTyped
{
	
	public var category:String = null;
	public var action:String = null;
	public var label:String = null;
	public var value:Null<Int> = null;

	public function new(category:String, action:String, ?label:String, ?value:Int) 
	{
		this.category = category;
		this.action = action;
		this.label = label;
		this.value = value;
	}
	
	override public function generateString():String
	{
		var params:String = '';
		params += getStringParam('ec', category, 150);
		params += getStringParam('ea', action, 500);
		params += getStringParam('el', label, 500);
		params += getIntParam('ev', value);
		return params;
	}
	
	public function getHitType():String { return 'event'; }
	
}