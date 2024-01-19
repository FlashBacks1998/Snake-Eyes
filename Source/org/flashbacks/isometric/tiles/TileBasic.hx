package org.flashbacks.isometric.tiles; 

import openfl.Assets; 

class TileBasic extends Tile{ 
    public static var bitmap = null;

    public function new() { 
        if(bitmap == null)
            bitmap = Assets.getBitmapData("assets/tileBasic.png"); 

        super(bitmap);
    }
}
