package org.flashbacks.physics;

import org.flashbacks.physics.colliders.PhysicsCollider;
import openfl.geom.Vector3D;

class PhysicsObject {
    public var mass:Float;
    public var acceleration:Vector3D;
    public var velocity:Vector3D;
    public var force:Vector3D;

    public var isSimulated:Bool;
    public var isDynamic:Bool;

    public var collider:PhysicsCollider;
    public var transform:PhysicsTransform;

    public function new(mass:Float, collider:PhysicsCollider, transform:PhysicsTransform, isSimulated:Bool = true, isDynamic:Bool = true) {
        this.mass = mass;
        this.acceleration = new Vector3D();
        this.velocity = new Vector3D();
        this.force = new Vector3D();
        this.collider = collider;
        this.transform = transform;

        this.isDynamic = isDynamic;
        this.isSimulated = isSimulated;
    }
}