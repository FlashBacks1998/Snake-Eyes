package org.flashbacks.isometric;

import openfl.display.DisplayObject;
import openfl.display.Sprite;
import org.flashbacks.isometric.tiles.TileBasic;
import org.flashbacks.isometric.tiles.Tile;

class IsometricWorld extends Sprite {
    public var tiles:Array<Tile> = [];

    public function new() {
        super(); 
    }

    public function fixTileDepths():Void {
        tiles.sort(function(a:Tile, b:Tile):Int {
            // Take into account the rigid body y-coordinate for better sorting
            var ta = a.y;
            var tb = b.y;

            return cast(ta - tb, Int);
        });

        for (i in 0...tiles.length) {
            setChildIndex(tiles[i], i);
        }
    }

    public function updateTileOnTheSreen(tile:Tile):Void {
        var i_x:Float = 1;
        var i_y:Float = 0.5;
        var j_x:Float = -1;
        var j_y:Float = 0.5;
        var scaleFactor:Float = 0.5;

        tile.x = (tile.position.x * i_x * scaleFactor + tile.position.z * j_x * scaleFactor) + 256;
        tile.y = (tile.position.x * i_y * scaleFactor + tile.position.z * j_y * scaleFactor) - tile.position.y + 128;
    }

    public function updateTilesOnTheSreen() {
        for (tile in tiles)
            updateTileOnTheSreen(tile);
    }

    public function addTile(tile:Tile) {
        tiles.push(tile);
        addChild(tile);
        updateTileOnTheSreen(tile);
    }
    
    public function removeTile(tile:Tile):Void {
        if (tiles.indexOf(tile) != -1) {
            tiles.remove(tile);
            removeChild(tile);
        }
    }
}
