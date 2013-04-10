package hxga;
import haxe.Http;
import nme.Lib;

class AppTracker
{
	
	private static var url:String = 'http://www.google-analytics.com/collect';
	private static var maxParallelRequests:Int = 5;
	
	static public var instance(default, null):AppTracker = null;
	
	static public function createInstance(trackingId:String, clientID:String, appName:String, ?appVersion:String) 
	{
		instance = new AppTracker(trackingId, clientID, appName, appVersion);
	}
	
	
	public var rootParams:RootParams;
	public var sampleRate:Float = 100.0;
	private var customParams:CustomParams = null;
	
	private var activeRequests:Int = 0;
	private var queue:Array<String>;

	public function new(trackingId:String, clientID:String, appName:String, ?appVersion:String) 
	{
		rootParams = new RootParams(trackingId, clientID);
		rootParams.sessionStart();
		rootParams.appName = appName;
		rootParams.appVersion = appVersion;
		rootParams.description = 'Not defined';
		queue = new Array<String>();
	}
	
	public function sendView(?viewName:String)
	{
		if (viewName != null)
			rootParams.description = viewName;
		internalSend('appview');
	}
	
	public function setView(viewName:String)
	{
		rootParams.description = viewName;
	}
	
	public function sendEvent(category:String, action:String, ?label:String, ?value:Int)
	{
		sendParams(new EventParams(category, action, label, value));
	}
	
	public function sendException(description:String, isFatal:Bool = true)
	{
		sendParams(new ExceptionParams(description, isFatal));
	}
	
	public function sendTiming(category:String, intervalInMilliseconds:Int, name:String, label:String)
	{
		sendParams(new TimingParams(category, name, intervalInMilliseconds, label));
	}
	
	public function sendParams(params:IParamsTyped)
	{
		internalSend(params.getHitType(), params.generateString());
	}
	
	public function setCustomDimension(index:Int, value:String)
	{
		if (customParams == null) customParams = new CustomParams();
		customParams.setDimension(index, value);
	}
	
	public function setCustomMetric(index:Int, value:Int)
	{
		if (customParams == null) customParams = new CustomParams();
		customParams.setMetric(index, value);
	}
	
	private function internalSend(hitType:String, params:String = '')
	{
		if (isSampledOut()) {
			return;
		}
		var paramString = 'v=1&t=' + hitType + getScreenSize() + rootParams.generateString() + params;
		if (customParams != null) {
			paramString += customParams.generateString();
			customParams = null;
		}
		sendHit(paramString);
	}
	
	private function getScreenSize() 
	{
		var w:Int = Lib.stage.stageWidth;
		var h:Int = Lib.stage.stageHeight;
		return '&sr=' + w + 'x' + h;
	}
	
	private function sendHit(paramString:String) 
	{
		if (activeRequests >= maxParallelRequests) {
			queue.push(paramString);
		} else {
			activeRequests++;
			var request:Http = new Http(url);
			request.setPostData(paramString);
			request.onData = request.onError = requestComplete;
			request.request(true);
		}
	}
	
	private function requestComplete(data:String) 
	{
		activeRequests--;
		if (queue.length > 0 && activeRequests < maxParallelRequests) {
			sendHit(queue.shift());
		}
	}
	
	private function isSampledOut():Bool
	{
		if (sampleRate <= 0.0) {
			return true;
		}
		if (sampleRate < 100.0) {
			if (rootParams.clientID != null && (Math.abs(rootParams.clientHashCode) % 10000 >= sampleRate * 100.0)) {
				return true;
			}
		}
		return false;
	}
	
}