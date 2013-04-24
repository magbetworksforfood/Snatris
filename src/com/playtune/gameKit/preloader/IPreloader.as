package com.playtune.gameKit.preloader {
    import flash.display.DisplayObjectContainer;

    public interface IPreloader {

        function get opened():Boolean

        function open(modal:Boolean = true):void

        function progress(value:Number):void

        function close():void
    }
}
