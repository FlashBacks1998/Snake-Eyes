package org.flashbacks.math;

import openfl.geom.Vector3D;

class MathUtils {
    public static function normalizeVector(vector:Vector3D):Vector3D {
        var length:Float = Math.sqrt(vector.x * vector.x + vector.y * vector.y + vector.z * vector.z);

        if (length > 0) {
            var normalizedX:Float = vector.x / length;
            var normalizedY:Float = vector.y / length;
            var normalizedZ:Float = vector.z / length;

            return new Vector3D(normalizedX, normalizedY, normalizedZ);
        } else {

            return new Vector3D();
        }
    }

    public static function dotVector(vector1:Vector3D, vector2:Vector3D):Float {
        var result:Float = vector1.x * vector2.x + vector1.y * vector2.y + vector1.z * vector2.z;

        return result;
    }
    
    public static function clamp(value:Float, min:Float, max:Float):Float {
        return value < min ? min : (value > max ? max : value);
    }
}
