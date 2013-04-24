package com.playtune.gameKit.navigation {

    import spark.components.SkinnableContainer;

    public class AbstractView extends SkinnableContainer implements IView {

        protected var _data:Object;

        public function AbstractView() {
        }

        public function update():void {
             throw new Error('Abstract method!');
        }

        public function set data(value:Object):void {
            if (_data != value) {
                _data = value;
            }
        }

        public function get data():Object {
            return _data;
        }

        public function dispose():void {
            throw new Error('Abstract method!');
        }
    }
}
