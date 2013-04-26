package {
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageOrientation;
    import flash.display.StageScaleMode;
    import flash.events.StageOrientationEvent;

    import com.playtune.gameKit.helpers.FPSMonitor;
    import com.playtune.gameKit.navigation.NavigatorController;
    import com.playtune.gameKit.resources.ImageResources;
    import com.playtune.gameKit.resources.ResourceManager;
    import com.playtune.snatris.views.GameLoopScreen;

    import flash.geom.Rectangle;

    import starling.core.Starling;

    [SWF(backgroundColor='0x32264A', frameRate='60', width='1024', height ='768')]
    public class Main extends Sprite {

        private var resources:ResourceManager = ResourceManager.instance;

        private var myStarling:Starling;

        public function Main():void {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;

//            var sprite:Sprite = new Sprite();
//            addChild(sprite);

            //addChild(new FPSMonitor());

//            NavigatorController.instance.init(this, sprite);

            //preload
            resources.multiload(ImageResources.preload, onComplete);

            //orientation
            var startOrientation:String = stage.orientation;
            if (startOrientation == StageOrientation.DEFAULT || startOrientation == StageOrientation.UPSIDE_DOWN) {
                stage.setOrientation(StageOrientation.ROTATED_RIGHT);
            } else {
                stage.setOrientation(startOrientation);
            }

            stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGING, orientationChangeListener);
        }



        private function onComplete():void {
            /*var bitmap:Bitmap = new Bitmap();
            bitmap.bitmapData = resources.getBitmapDataById(ImageResources.BACKGROUND.id);
            //bitmap.scale9Grid = new Rectangle(50, 50, 100, 100);
            bitmap.width = stage.stageWidth;
            bitmap.height = stage.stageHeight;

            addChildAt(bitmap, 0);*/

            myStarling = new Starling(GameLoopScreen, stage);
            myStarling.antiAliasing = 1;
            myStarling.showStats = true;
            myStarling.start();
        }

        private function orientationChangeListener(e:StageOrientationEvent) {
            if (e.afterOrientation == StageOrientation.DEFAULT || e.afterOrientation == StageOrientation.UPSIDE_DOWN) {
                e.preventDefault();
            }
        }
    }
}