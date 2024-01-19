package org.flashbacks.physics.solvers;

import openfl.geom.Vector3D; 
import org.flashbacks.physics.PhysicsCollision; 

typedef PhysicsSmoothPositionSolverDelta = { deltaA:Vector3D, deltaB:Vector3D };

class PhysicsSmoothPositionSolver {
    public static function Solve(collisions:Array<PhysicsCollision>, dt:Float):Void {  
        var deltas:Array<PhysicsSmoothPositionSolverDelta> = [];
        
        for (collision in collisions) {
            var objA:PhysicsObject = collision.objA;
            var objB:PhysicsObject = collision.objB;

            var aInvMass:Float = objA?.isSimulated ? 1.0 / objA.mass : 0.0;
            var bInvMass:Float = objB?.isSimulated ? 1.0 / objB.mass : 0.0;

            var percent:Float = 0.8;
            var slop:Float = 0.01;

            var correction:Vector3D = collision.points.normal.clone();
            correction.scaleBy(percent * Math.max(collision.points.depth - slop, 0.0) / (aInvMass + bInvMass));

            var deltaA:Vector3D = objA?.isSimulated ? /*correction.scaleBy(aInvMass)*/ new Vector3D(correction.x * aInvMass, correction.y * aInvMass, correction.z * aInvMass) : new Vector3D();
            var deltaB:Vector3D = objB?.isSimulated ? /*correction.scaleBy(bInvMass)*/ new Vector3D(correction.x * bInvMass, correction.y * bInvMass, correction.z * bInvMass) : new Vector3D();

            deltas.push({ deltaA: deltaA, deltaB: deltaB });
        }

        for (i in 0...collisions.length) {
            var objA:PhysicsObject = collisions[i].objA;
            var objB:PhysicsObject = collisions[i].objB;

            if (objA?.isSimulated) {
                objA.transform.position = objA.transform.position.subtract(deltas[i].deltaA);
            }

            if (objB?.isSimulated) {
                objB.transform.position = objB.transform.position.add(deltas[i].deltaB);
            }
        }
    }
}
