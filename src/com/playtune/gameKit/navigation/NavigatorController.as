package com.playtune.gameKit.navigation {
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.text.FontType;
    import flash.utils.Dictionary;

    public class NavigatorController {

        private static var _instance:NavigatorController;

        private var container:DisplayObjectContainer;
        private var popUpContainer:DisplayObjectContainer;
        private var modalPopUps:Vector.<DisplayObject> = new <DisplayObject>[];

        private var viewByType:Dictionary = new Dictionary();

        private var currentView:AbstractView;

        public static function get instance():NavigatorController {
            if (!_instance) _instance = new NavigatorController(new SingletonData());
            return _instance;
        }

        public function NavigatorController(singletonData:SingletonData) {
            if (!singletonData) {
                throw new Error('Singleton');
            }
        }

        public function init(container:DisplayObjectContainer, popUpContainer:DisplayObjectContainer):void {
            if (!container) {
                throw new Error('no container');
            }

            if (!popUpContainer) {
                throw new Error('no popUpContainer')
            }

            this.container = container;
            this.popUpContainer = popUpContainer;
        }

        //todo
        public function show(type:InterfaceType, data:Object):void {
            if (currentView && container.contains(currentView)) {
                container.removeChild(currentView);
            }

            if (!viewByType[type]) {
                viewByType[type] = new type.clazz();
            }

            var view:AbstractView = viewByType[type];
            view.data = data;
            view.update();

            currentView = view;

            container.addChild(view)
        }

        public function addPopUp(popUp:DisplayObject, modal:Boolean = false):void {
            if (modal) {
                container.mouseChildren = false;
                modalPopUps.push(popUp);
            }

            popUpContainer.addChild(popUp);

            popUp.x = popUpContainer.width - popUp.width >> 1;
            popUp.y = popUpContainer.height - popUp.height >> 1;
        }

        public function removePopUp(popUp:DisplayObject = null):void {
            if (!popUp && popUpContainer.numChildren) {
                popUpContainer.removeChildren();
            } else if (popUpContainer.contains(popUp)) {
                popUpContainer.removeChild(popUp);
                var index:Number = modalPopUps.indexOf(popUp);
                if (index != -1) {
                    modalPopUps.splice(index, 1);
                }
            }

            if (!popUpContainer.numChildren || !modalPopUps.length) {
                container.mouseChildren = true;
            }
        }
    }
}

class SingletonData {
    public function SingletonData():void {
        //private class constructor
    }
}
