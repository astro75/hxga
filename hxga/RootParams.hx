package hxga;

class RootParams extends BaseParams
{
	
	// DJB Hash
	private static function hashCode(s:String) {
	    var hash = 5381;
		var len = s.length;
		for(i in 0...len) hash = ((hash << 5) + hash) + s.charCodeAt(i);
		return hash;
    }
	
	public var trackingID:String;
	public var clientID(default, setClientId):String;
	public var clientHashCode(default, null):Int;
	
	public function setClientId(id:String) 
	{
		clientHashCode = hashCode(id);
		clientID = id;
		return clientID;
	}

	private var sessionControl:String = null;
	public var appName:String = null;
	public var appVersion:String = null;
	public var description:String = null;

	public function new(trackingID:String, clientID:String) 
	{
		this.trackingID = trackingID;
		this.clientID = clientID;
	}
	
	public function sessionStart()
	{
		sessionControl = 'start';
	}
	
	public function sessionEnd()
	{
		sessionControl = 'end';
	}
	
	public function sessionNormal()
	{
		sessionControl = null;
	}
	
	override public function generateString():String
	{
		var params:String = '';
		params += getStringParam('tid', trackingID);
		params += getStringParam('cid', clientID);
		params += getStringParam('sc', sessionControl);
		sessionNormal();
		params += getStringParam('an', appName, 100);
		params += getStringParam('av', appVersion, 100);
		params += getStringParam('cd', description, 2048);
		return params;
	}
	
}