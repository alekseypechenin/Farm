package Core
{
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import mx.collections.*;
	import mx.controls.Alert;
    		
	public final class RequestManager	
	{
		public static const METHOD_POST:String = "POST";		
		public static const METHOD_GET:String = "GET";
		public static const RETURNSALLGIVES:String = "http://localhost:3000/fields/indextoclient";
		public static const ADDGIVE:String = "http://localhost:3000/fields/createtoserver";
		public static const GROWGIVES:String = "http://localhost:3000/fields/growallfields";			
		private var httprequest: HTTPService = new HTTPService();
		
		private var resultHandler:Function;
		private var faultHandler:Function;
		private var requestParams:Object = null;
		
		public function RequestManager(resulHandler:Function = null,
									 faultHandler:Function = null)
		{
			this.resultHandler = resulHandler;
			this.faultHandler = faultHandler;		
		}
			
		public function requestQuery(reqType:String,
									 reqPar:Object = null,
									 reqMethod:String = METHOD_POST
									 ):void
		{			
			httprequest.url = reqType;
			httprequest.method = reqMethod;
			requestParams = reqPar;
			httprequest.resultFormat = "e4x";
			
			if (resultHandler != null)
			{
				httprequest.addEventListener(ResultEvent.RESULT, resultHandler);
			}
			if (faultHandler != null)
			{								
				httprequest.addEventListener(FaultEvent.FAULT, faultHandler);	
			}																			
		}
		
		public function requestSend():void
		{
			httprequest.send(requestParams);			
		}
	}
	
}