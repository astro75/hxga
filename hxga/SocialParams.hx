package hxga;

class SocialParams extends BaseParams, implements IParamsTyped
{
	
	public var network:String = null;
	public var action:String = null;
	public var target:String = null;

	public function new(network:String, action:String, target:String) 
	{
		this.network = network;
		this.action = action;
		this.target = target;
	}
	
	override public function generateString():String
	{
		var params:String = '';
		params += getStringParam('sn', network, 50);
		params += getStringParam('sa', action, 50);
		params += getStringParam('st', target, 2048);
		return params;
	}
	
	public function getHitType():String { return 'social'; }
	
}