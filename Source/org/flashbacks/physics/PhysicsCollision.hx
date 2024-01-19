package org.flashbacks.physics;
  
class PhysicsCollision {
    public var objA:PhysicsObject;
    public var objB:PhysicsObject;
    public var points:PhysicsCollisionPoints;
    
    public function new(objA:PhysicsObject, objB:PhysicsObject, points:PhysicsCollisionPoints) {
        this.objA = objA;
        this.objB = objB;
        this.points = points;
    }
}