package org.flashbacks.isometric.tiles; 

import openfl.Assets; 

class TileBall extends Tile{ 
    public static var bitmap = null;

    public function new() { 
        if(bitmap == null)
            bitmap = Assets.getBitmapData("assets/tileBall.png"); 

        super(bitmap);
    }
}
