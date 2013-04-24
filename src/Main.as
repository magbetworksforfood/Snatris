package {
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageOrientation;
    import flash.display.StageScaleMode;
    import flash.events.StageOrientationEvent;

    import com.playtune.gameKit.helpers.FPSMonitor;
    import com.playtune.gameKit.navigation.NavigatorController;
    import com.playtune.gameKit.resources.ImageResources;
    import com.playtune.gameKit.resources.ResourceManager;
    import com.playtune.snatris.views.GameTableView;

    [SWF(backgroundColor='0x32264A', frameRate='60', width='1024', height ='768')]
    public class Main extends Sprite {

        private var resources:ResourceManager = ResourceManager.instance;

        public function Main():void {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;

            var sprite:Sprite = new Sprite();
            addChild(sprite);

            NavigatorController.instance.init(this, sprite);

            resources.multiload(ImageResources.preload, onComplete);

            var startOrientation:String = stage.orientation;
            if (startOrientation == StageOrientation.DEFAULT || startOrientation == StageOrientation.UPSIDE_DOWN) {
                stage.setOrientation(StageOrientation.ROTATED_RIGHT);
            } else {
                stage.setOrientation(startOrientation);
            }

            stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGING, orientationChangeListener);
        }



        private function onComplete():void {
            var bitmap:Bitmap = new Bitmap();
            bitmap.bitmapData = resources.getBitmapDataById(ImageResources.BACKGROUND.id);
            //bitmap.scale9Grid = new Rectangle(50, 50, 100, 100);
            bitmap.width = stage.stageWidth;
            bitmap.height = stage.stageHeight;

            addChildAt(bitmap, 0);

            var gameTableView:GameTableView = new GameTableView();
            addChild(gameTableView);

            addChild(new FPSMonitor());
        }

        private function orientationChangeListener(e:StageOrientationEvent) {
            if (e.afterOrientation == StageOrientation.DEFAULT || e.afterOrientation == StageOrientation.UPSIDE_DOWN) {
                e.preventDefault();
            }
        }


    }
}