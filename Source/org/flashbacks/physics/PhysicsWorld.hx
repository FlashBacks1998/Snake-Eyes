package org.flashbacks.physics;

import org.flashbacks.physics.solvers.PhysicsSolver.PhysicsSolverFunction;
import openfl.geom.Vector3D;

class PhysicsWorld {
    public var objects:Array<PhysicsObject> = [];
    private var solvers:Array<PhysicsSolverFunction> = [];
    private var gravity:Vector3D = new Vector3D(0, -9.81, 0);

    public function new() {

    }

    public function addObject(object:PhysicsObject):Void {
        objects.push(object);
    }

    public function removeObject(object:PhysicsObject):Void {
        objects.remove(object);
    }

    public function addSolver(solver:PhysicsSolverFunction):Void {
        solvers.push(solver);
    }

    public function removeSolver(solver:PhysicsSolverFunction):Void {
        solvers.remove(solver);
    }

    public function step(dt:Float):Void { 

        resolveCollisions(dt);

        for (obj in objects) {
            // Apply a force manually 
            obj.force.x += obj.mass * gravity.x;
            obj.force.y += obj.mass * gravity.y;
            obj.force.z += obj.mass * gravity.z;

            // Update velocity and position manually
            obj.velocity.x += obj.force.x / obj.mass * dt;
            obj.velocity.y += obj.force.y / obj.mass * dt;
            obj.velocity.z += obj.force.z / obj.mass * dt;

            obj.transform.position.x += obj.velocity.x * dt;
            obj.transform.position.y += obj.velocity.y * dt;
            obj.transform.position.z += obj.velocity.z * dt; 

            // Reset net force manually
            obj.force.setTo(0,0,0); 
        }
    }

    private function resolveCollisions(dt:Float):Void {
        var collisions:Array<PhysicsCollision> = [];

        for (a in objects)
            for (b in objects) { 
                if (a.collider == null || b.collider == null || a == null || b == null)
                    continue;

                var points:PhysicsCollisionPoints = PhysicsAlgorithm.TestCollisionBetweenObjects(a, b);

                if(points != null && points.hasCollision) {
                    collisions.push(new PhysicsCollision(a, b, points));
                }
            }  
        
        for (solver in solvers)
            solver(collisions, dt);
    }
}
