package org.flashbacks.physics.colliders; 

import openfl.geom.Vector3D;
import org.flashbacks.physics.colliders.PhysicsCollider.PhysicsColliderType;

class PhysicsBoxCollider extends PhysicsCollider {
    public var size:Vector3D;
    public var center:Vector3D;

    public function new(size:Vector3D) {
        super(PhysicsColliderType.BOX);
        this.size = size;
        this.center = new Vector3D();
    }
}

typedef PhysicsBox = PhysicsBoxCollider;
