package org.flashbacks.physics.colliders;

import openfl.geom.Vector3D;
import org.flashbacks.physics.colliders.PhysicsCollider.PhysicsColliderType;

class PhysicsSphereCollider extends PhysicsCollider {
    public var center:Vector3D;
    public var radius:Float;

    public function new(center:Vector3D, radius:Float) {
        super(PhysicsColliderType.SPHERE);
        this.center = center;
        this.radius = radius;
    }
}

typedef PhysicsSphere = PhysicsSphereCollider; 