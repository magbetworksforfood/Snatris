package com.playtune.snatris.data {
    import com.playtune.gameKit.data.Enum;

    public class SxState extends Enum {

        public static const PAUSED:SxState = new SxState('paused');
        public static const RUNNIG:SxState = new SxState('running');

        public function SxState(id:String):void {
            super(id)
        }
    }
}
