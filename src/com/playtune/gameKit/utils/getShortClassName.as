package com.playtune.gameKit.utils {
    import flash.utils.getQualifiedClassName;

    public function getShortClassName(o:Object):String {
        var clName:String = getQualifiedClassName(o);
        return clName.substring(clName.indexOf("::", 0) + 2, clName.length);
    }
}