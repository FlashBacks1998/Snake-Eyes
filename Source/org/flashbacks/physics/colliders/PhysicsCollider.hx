package org.flashbacks.physics.colliders;

enum PhysicsColliderType {
    SPHERE;
    PLANE;
    BOX;
}

class PhysicsCollider {
    public var type:PhysicsColliderType;

    public function new(type:PhysicsColliderType) {
        this.type = type;
    }
}
