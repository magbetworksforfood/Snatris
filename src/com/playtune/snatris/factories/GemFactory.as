package com.playtune.snatris.factories {
    import flash.errors.IOError;

    import com.playtune.snatris.entities.Gem;
    import com.playtune.snatris.entities.GemColor;
    import com.playtune.gameKit.resources.ImageResources;

    public class GemFactory {
        public function GemFactory():void {
        }

        public static function getImageIdByType(type:GemColor):String {

            var id:String = '';
            switch (type) {
                case GemColor.BLUE:
                    id = ImageResources.GEM_BLUE.id;
                    break;
                case GemColor.RED:
                    id = ImageResources.GEM_RED.id
                    break;
                case GemColor.VIOLET:
                    id = ImageResources.GEM_VIOLET.id
                    break;
                case GemColor.CYAN:
                    id = ImageResources.GEM_CYAN.id
                    break;
                case GemColor.ORANGE:
                    id = ImageResources.GEM_ORANGE.id
                    break;
                case GemColor.YELLOW:
                    id = ImageResources.GEM_YELLOW.id
                    break;
                case GemColor.GREEN:
                    id = ImageResources.GEM_GREEN.id
                    break;
                default:
                    throw new IOError('no gemColor');
            }

            return id;

        }
    }
}
