package com.playtune.gameKit.resources {
    public class ExternalResource {

        public var id:String;
        public var url:String;
        public var type:ResourceType;
        public var rewritable:Boolean;

        public var data:Object;

        public function ExternalResource(id:String,  url:String,  type:ResourceType = null, rewritable:Boolean = false) {
            type ||= ResourceType.IMG;

            this.id = id;
            this.url = url;
            this.type = type;
            this.rewritable = rewritable;
        }
    }
}
