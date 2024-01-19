package org.flashbacks.physics.colliders;

import openfl.geom.Vector3D;
import org.flashbacks.physics.colliders.PhysicsCollider.PhysicsColliderType;

class PhysicsPlaneCollider extends PhysicsCollider {
    public var normal:Vector3D;
    public var distance:Float;

    public function new(normal:Vector3D, distance:Float) {
        super(PhysicsColliderType.PLANE);
        this.normal = normal;
        this.distance = distance;
    }
}
typedef PhysicsPlane = PhysicsPlaneCollider;