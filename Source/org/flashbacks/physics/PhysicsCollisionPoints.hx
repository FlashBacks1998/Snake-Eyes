package org.flashbacks.physics;

import openfl.geom.Vector3D;

class PhysicsCollisionPoints {
    public var A:Vector3D;
    public var B:Vector3D;
    public var normal:Vector3D;
    public var depth:Float;
    public var hasCollision:Bool;

    public function new(a:Vector3D, b:Vector3D, normal:Vector3D, depth:Float, hasCollision:Bool) {
        this.A = a;
        this.B = b;
        this.normal = normal;
        this.depth = depth;
        this.hasCollision = hasCollision;
    }
}
