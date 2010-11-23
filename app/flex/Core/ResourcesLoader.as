package Core
{
	import Entities.GameObject;
	
	import Utils.GraphicsResource;
	
	import flash.display.Loader;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	
	import mx.controls.ProgressBar;
	import Entities.BaseObject;
	
	public class ResourcesLoader
	{
		public var showProgressBar:Boolean = false;
		static public var resourcePool:Dictionary = new Dictionary;
		
		private var lastError:String = null;
		private var resourceName:String = null;
		private var _complited:Boolean = false;
		private var loader:URLLoader = new URLLoader();
		private var progressBar:ProgressBar = null;
		private var resourceURL:String = null;
		private var graphis:GraphicsResource = null;
		private var loaderImage:Loader = null;
		private var gameObject: GameObject = null; 

		
		public function ResourcesLoader(gameObject:GameObject,progressBar:ProgressBar = null)
		{ 
			this.gameObject = gameObject;
			
			// For future using
			this.progressBar = progressBar;
			this.loader.dataFormat = URLLoaderDataFormat.BINARY; 
			this.configureListeners(loader);
		}
		
		public function complited():Boolean
		{
		 	return this._complited;
		}
		
		public function lastErrors():String
		{
			return this.lastError;
		}
		
		public function load(resourceName:String):void
		{
			configureURL(resourceName);
			_complited = false;
			
			if (resourcePool[resourceName] != null)
			{
				_complited = true;
				graphis = resourcePool[resourceName];
				this.gameObject.graphics = graphis;
				return;
			} 
			
			this.loader.load(new URLRequest(resourceURL));
		}
		
		public function getImage():GraphicsResource
		{
			if (!_complited) return null;
			return graphis;
		}
		
		private function configureURL(resourceName:String):void
		{
			this.resourceName = resourceName;
			resourceURL = GameObjectManager.Instance.serverAddress + resourceName;
		}
		
		private function configureListeners(dispatcher:IEventDispatcher):void 
		{
           dispatcher.addEventListener(Event.COMPLETE, completeHandler);
           dispatcher.addEventListener(Event.OPEN, openHandler);
           dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
           dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
           dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
           dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        }

        private function completeHandler(event:Event):void
        {
        	_complited = true;
            trace(this + "completeHandler: " + loader.data);
            
            loaderImage = new Loader();
            loaderImage.loadBytes(loader.data);
            loaderImage.contentLoaderInfo.addEventListener(Event.COMPLETE, finishLoader);   
        }
        
        private function finishLoader(event:Event):void 
      	{
			graphis = new GraphicsResource(loaderImage);
            resourcePool[resourceName] = graphis;
            this.gameObject.graphics = graphis;
		}


        private function openHandler(event:Event):void {
            trace(this + "openHandler: " + event);
        }

        private function progressHandler(event:ProgressEvent):void 
        {
        	if (this.progressBar != null)
        	{
	        	var percent:Number = Math.round( event.bytesLoaded 
				/ event.bytesTotal * 100 );
				trace(percent);	 
				this.progressBar.setProgress(percent,100);
        	} 
            trace(this + "progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
        }

        private function securityErrorHandler(event:SecurityErrorEvent):void
        {
            trace(this + "securityErrorHandler: " + event);
            this.lastError = this + "securityErrorHandler: " + event;
        }

        private function httpStatusHandler(event:HTTPStatusEvent):void
        {
            trace(this + "httpStatusHandler: " + event);
            this.lastError = this + "httpStatusHandler: " + event;
        }

        private function ioErrorHandler(event:IOErrorEvent):void
        {
            trace(this + "ioErrorHandler: " + event);
            this.lastError = this + "ioErrorHandler: " + event;
        }


	}
}