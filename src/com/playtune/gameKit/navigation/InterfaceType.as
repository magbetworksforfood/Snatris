package com.playtune.gameKit.navigation {
    import com.playtune.gameKit.data.Enum;

    public class InterfaceType extends Enum {

//        public static const START:InterfaceType = new InterfaceType('startView', StartView);
//        public static const SEEK_AND_FIND:InterfaceType = new InterfaceType('seekAndFind', SeekAndFindView);
//        public static const SCORE:InterfaceType = new InterfaceType('score', ScoreView);


        public var clazz:Class;

        public function InterfaceType(id:String, clazz:Class) {
            super(id);
            this.clazz = clazz;
        }
    }
}
