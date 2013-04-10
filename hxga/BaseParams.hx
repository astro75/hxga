package hxga;


class BaseParams implements IParams
{
	
	public function generateString():String
	{
		return '';
	}
	
	private function getStringParam(name:String, param:String, length:Int = 1000):String
	{
		if (param == null) return '';
		return '&' + name + '=' + StringTools.urlEncode(param).substr(0, length);
	}
	
	private function getIntParam(name:String, param:Null<Int>):String
	{
		if (param == null) return '';
		return '&' + name + '=' + Std.string(param);
	}
	
	private function getBoolParam(name:String, param:Null<Bool>):String
	{
		if (param == null) return '';
		return '&' + name + '=' + ((param == true) ? '1' : '0');
	}
	
}