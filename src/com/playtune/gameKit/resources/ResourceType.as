package com.playtune.gameKit.resources {
    import com.playtune.gameKit.data.Enum;

    public class ResourceType extends Enum {

        public static const IMG:ResourceType = new ResourceType('img');
        public static const XML:ResourceType = new ResourceType('txt');

        public function ResourceType(id:String) {
            super(id);
        }
    }
}
