
package com.playtune.gameKit.resources {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.events.ErrorEvent;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.system.ImageDecodingPolicy;
    import flash.system.LoaderContext;
    import flash.utils.Dictionary;
    import com.playtune.gameKit.preloader.IPreloader;
    import com.playtune.gameKit.preloader.Preloader;

    import starling.textures.Texture;

    public class ResourceManager extends EventDispatcher {

        private static var _instance:ResourceManager;

        private var resourcesById:Dictionary = new Dictionary();
        private var dataByUrl:Dictionary = new Dictionary();

        private var loader:Loader = new Loader();
        private var loaderContext:LoaderContext;
        private var urlLoader:URLLoader = new URLLoader();
        private var preloader:IPreloader = new Preloader();

        private var currentLoadingItem:LoadingQueueItem;
        private var busy:Boolean;
        private var loadingQueue:Vector.<LoadingQueueItem> = new <LoadingQueueItem>[];
        private var loaded:int;

        private var textureById:Dictionary = new Dictionary();
        private var bitmapDataById:Dictionary = new Dictionary();

        public static function get instance():ResourceManager {
            if (!_instance) _instance = new ResourceManager(new SingletonData());
            return _instance;
        }

        public function ResourceManager(singletonData:SingletonData):void {
            if (!singletonData) {
                throw new Error('Singleton');
            }

            init()

        }

        private function init():void {

            loaderContext= new LoaderContext();
            loaderContext.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;

            urlLoader.addEventListener(ProgressEvent.PROGRESS, onProgress);
            urlLoader.addEventListener(Event.COMPLETE, onComplete);
            urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);

            loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
            loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus);
        }

        public function getBitmapDataById(id:String):BitmapData {
            if (bitmapDataById[id] == undefined) {
                var resource:ExternalResource = resourcesById[id];
                bitmapDataById[id] = resource && resource.type == ResourceType.IMG ? resource.data as BitmapData : null;
            }

            return bitmapDataById[id];
        }

        public function getTextureById(id:String):Texture {
            if (textureById[id] == undefined) {
                textureById[id] = Texture.fromBitmapData(getBitmapDataById(id));
            }
            return textureById[id];
        }

        public function getBitmapData(resource:ExternalResource):void {
            //todo
        }

        public function getXmlById(id:String):XML {
            var resource:ExternalResource = resourcesById[id];

            return resource && resource.type == ResourceType.XML ? resource.data as XML : null;
        }

        public function multiload(resources:Vector.<ExternalResource>, onComplete:Function = null):void {
            if (resources.length) {
                var length:uint = resources.length;
                for (var i:uint = 0; i < length; i++) {
                    load(resources[i], i == length - 1 ? onComplete : null);
                }
            } else {
                onComplete();
            }

        }

        public function load(resource:ExternalResource, onComplete:Function = null):void {

            if (!resource.rewritable && resourcesById[resource.id]) {
                trace(resource.id, ' already loaded');
                if (onComplete) {
                    onComplete();
                }
                return;
            }

            if (dataByUrl[resource.url]) {
                resource.data = dataByUrl[resource.url];
                resourcesById[resource.id] = resource;
                if (onComplete) {
                    onComplete();
                }
            } else {
                loadingQueue.push(new LoadingQueueItem(resource, onComplete));

                if (!busy) {
                    startLoad(loadingQueue.shift());
                }
            }

        }

        private function startLoad(item:LoadingQueueItem):void {
            busy = true;

            currentLoadingItem = item;

            if (!preloader.opened) {
                //preloader.open();
            }

            var resource:ExternalResource = item.resource;
            if (resource.type == ResourceType.XML) {
                urlLoader.load(new URLRequest(resource.url));
            } else if (resource.type == ResourceType.IMG) {
                loader.load(new URLRequest(resource.url), loaderContext);
            }
        }

        private function onProgress(event:ProgressEvent):void {
            preloader.progress(((event.bytesLoaded / event.bytesTotal) + loaded) / (loadingQueue.length + loaded + 1));
        }

        private function onComplete(event:Event):void {
            var resource:ExternalResource = currentLoadingItem.resource;
            if (resource.type == ResourceType.XML) {
                resource.data = XML(urlLoader.data);
                resourcesById[resource.id] = resource;
            } else if (resource.type == ResourceType.IMG) {
                resource.data = Bitmap(loader.content).bitmapData;
                resourcesById[resource.id] = resource;
            }

            if (currentLoadingItem.callback) {
                currentLoadingItem.callback();
            }

            dataByUrl[resource.url] = resource.data;

            currentLoadingItem = null;

            if (loadingQueue.length) {
                loaded++;
                startLoad(loadingQueue.shift());
            } else {
                busy = false;
                loaded = 0;
                dispatchEvent(new Event(Event.COMPLETE));

                //preloader.close();
            }

        }

        private function onError(event:ErrorEvent):void {
            //Alert.show('Ошибка загрузки!' + event.text);
            trace('Ошибка загрузки!' + event.text);
        }

        private function onHttpStatus(event:HTTPStatusEvent):void {
            trace('status');
        }
    }
}

import com.playtune.gameKit.resources.ExternalResource;

class SingletonData {
    public function SingletonData():void {
        //private class constructor
    }
}

class LoadingQueueItem {
    public var resource:ExternalResource;
    public var callback:Function;

    public function LoadingQueueItem(resource:ExternalResource, callback:Function):void {
        this.resource = resource;
        this.callback = callback;
    }
}
