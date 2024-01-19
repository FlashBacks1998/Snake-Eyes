package org.flashbacks.physics;
 
import org.flashbacks.math.MathUtils;
import org.flashbacks.physics.colliders.PhysicsBoxCollider;
import openfl.utils.Function;
import haxe.EnumTools.EnumValueTools;
import openfl.geom.Vector3D;
import org.flashbacks.physics.colliders.PhysicsSphereCollider;
import org.flashbacks.physics.colliders.PhysicsPlaneCollider;
import org.flashbacks.physics.colliders.PhysicsCollider;

typedef PhysicsCollisionFunction = PhysicsCollider->PhysicsTransform->PhysicsCollider->PhysicsTransform->PhysicsCollisionPoints;

class PhysicsAlgorithm {
    public static final CollisionFunctionMatrix:Array<Array<PhysicsCollisionFunction>> = [
        [TestCollisionBetweenSphereSphere, TestCollisionBetweenPlaneSphere, TestCollisionBetweenSphereBox],
        [TestCollisionBetweenPlaneSphere, null, null],
        [TestCollisionBetweenBoxSphere, null, null]
    ];

    public static function TestCollisionBetweenObjects(a:PhysicsObject, b:PhysicsObject):PhysicsCollisionPoints {
        var t1 = EnumValueTools.getIndex(a.collider.type);
        var t2 = EnumValueTools.getIndex(b.collider.type);
     
        var func = CollisionFunctionMatrix[t1][t2];
    
        if(func == null)
            return new PhysicsCollisionPoints(null, null, null, 0, false);
     

        return func(a.collider, a.transform, b.collider, b.transform);
    }
    
    public static function TestCollisionBetweenSphereSphere(a:PhysicsCollider, ta:PhysicsTransform, b:PhysicsCollider, tb:PhysicsTransform):PhysicsCollisionPoints { 
        var A = cast(a, PhysicsSphereCollider);
        var B = cast(b, PhysicsSphereCollider);

        var aCenter:Vector3D = A.center.add(ta.position);
        var bCenter:Vector3D = B.center.add(tb.position);
        var aRadius:Float = A.radius * ta.scale;
        var bRadius:Float = B.radius * tb.scale;

        var radiusSum:Float = aRadius + bRadius;
        var ab:Vector3D = bCenter.subtract(aCenter);
        var distance:Float = ab.length;
 
        if (distance < 0.00001 || distance > aRadius + bRadius) {
            return new PhysicsCollisionPoints(null, null, null, 0, false);
        }

        var normal:Vector3D = new Vector3D(ab.x / distance, ab.y / distance, ab.z / distance);

        var collisionDepth:Float = aRadius + bRadius - distance;

        var aDeep:Vector3D = new Vector3D(aCenter.x + normal.x * aRadius, aCenter.y + normal.y * aRadius, aCenter.z + normal.z * aRadius);
        var bDeep:Vector3D = new Vector3D(bCenter.x - normal.x * bRadius, bCenter.y - normal.y * bRadius, bCenter.z - normal.z * bRadius);

        return new PhysicsCollisionPoints(aDeep, bDeep, normal, collisionDepth, true);
    }
 
    //BUG: Uncaught exception - Invalid field access : x WHAT THE FUCK ARE YOU TALKING ABOUT
    public static function TestCollisionBetweenSphereBox(a:PhysicsCollider, ta:PhysicsTransform, b:PhysicsCollider, tb:PhysicsTransform):PhysicsCollisionPoints {
        // Step 1: Get Sphere and Box Properties
        var sphere:PhysicsSphereCollider = cast(a, PhysicsSphereCollider);
        var box:PhysicsBoxCollider = cast(b, PhysicsBoxCollider);
     
        // Step 2: Transform to World Space
        var sphereCenter:Vector3D = new Vector3D(
            sphere.center.x + ta.position.x,
            sphere.center.y + ta.position.y,
            sphere.center.z + ta.position.z
        );
        
    
        var boxCenter:Vector3D = new Vector3D(
            box.center.x + tb.position.x,
            box.center.y + tb.position.y,
            box.center.z + tb.position.z
        );
    
        // Step 3: Calculate Closest Point on the Box to Sphere
        var closestPoint:Vector3D = new Vector3D(
            MathUtils.clamp(sphereCenter.x, boxCenter.x - box.size.x / 2, boxCenter.x + box.size.x / 2),
            MathUtils.clamp(sphereCenter.y, boxCenter.y - box.size.y / 2, boxCenter.y + box.size.y / 2),
            MathUtils.clamp(sphereCenter.z, boxCenter.z - box.size.z / 2, boxCenter.z + box.size.z / 2)
        );
    
        // Step 4: Calculate Normal Vector
        var normal:Vector3D = new Vector3D(
            closestPoint.x - sphereCenter.x,
            closestPoint.y - sphereCenter.y,
            closestPoint.z - sphereCenter.z
        );
    
        var distance:Float = Math.sqrt(normal.x * normal.x + normal.y * normal.y + normal.z * normal.z);
    
        // Step 5: Normalize Normal Vector
        if (distance > 0) {
            normal.x /= distance;
            normal.y /= distance;
            normal.z /= distance;
        } else {
            normal.setTo(0, 0, 0);
        }
    
        // Step 6: Calculate Squared Distance
        var distanceSquared:Float = MathUtils.dotVector(normal, normal);
    
        // Step 7: Check for Collision
        var radiusSquared:Float = sphere.radius * sphere.radius;
        if (distanceSquared > radiusSquared) {
            // No collision, return empty collision points
            return new PhysicsCollisionPoints(null, null, null, 0, false);
        }
    
        // Step 8: Calculate Collision Information
        var penetrationDepth:Float = sphere.radius - Math.sqrt(radiusSquared - distanceSquared);
    
        // Step 9: Calculate Contact Points
        var scaledNormal:Vector3D = new Vector3D(
            normal.x * sphere.radius,
            normal.y * sphere.radius,
            normal.z * sphere.radius
        );
    
        var sphereContact:Vector3D = new Vector3D(
            sphereCenter.x + scaledNormal.x,
            sphereCenter.y + scaledNormal.y,
            sphereCenter.z + scaledNormal.z
        );
    
        var boxContact:Vector3D = closestPoint;
    
        // Step 10: Return Collision Points
        return new PhysicsCollisionPoints(sphereContact, boxContact, normal, penetrationDepth, true);
    }
    

    public static function TestCollisionBetweenPlaneSphere(a:PhysicsCollider, ta:PhysicsTransform, b:PhysicsCollider, tb:PhysicsTransform):PhysicsCollisionPoints {
        return null;
    }
    
    public static function TestCollisionBetweenSpherePlane(a:PhysicsCollider, ta:PhysicsTransform, b:PhysicsCollider, tb:PhysicsTransform):PhysicsCollisionPoints {
        return TestCollisionBetweenPlaneSphere(b, tb, a, ta);
    }

    public static function TestCollisionBetweenBoxSphere(a:PhysicsCollider, ta:PhysicsTransform, b:PhysicsCollider, tb:PhysicsTransform) {
        return TestCollisionBetweenSphereBox(b, tb, a, ta);
    }
}
