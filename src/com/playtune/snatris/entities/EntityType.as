package com.playtune.snatris.entities {
    import com.playtune.gameKit.data.Enum;

    public class EntityType extends Enum {

        public static const GEM:EntityType = new EntityType('gem');

        public function EntityType(id:String):void {
            super(id);
        }
    }
}
