package org.flashbacks.isometric.tiles;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.BitmapData;  
import openfl.geom.Vector3D;

class Tile extends Sprite{
    
    // Properties
    public var position:Vector3D;

    // Constructor
    public function new(bmp:BitmapData) {
        super();

        position = new Vector3D();

        addChild(new Bitmap(bmp));
    }
}
