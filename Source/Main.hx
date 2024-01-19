package;

import org.flashbacks.isometric.tiles.TileBall;
import org.flashbacks.isometric.tiles.TileBasic;
import org.flashbacks.physics.colliders.PhysicsBoxCollider.PhysicsBox;
import org.flashbacks.isometric.IsometricWorld; 
import haxe.Timer;
import org.flashbacks.physics.PhysicsCollision;
import org.flashbacks.physics.colliders.PhysicsCollider;
import org.flashbacks.physics.PhysicsWorld;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
import org.flashbacks.physics.PhysicsTransform;
import org.flashbacks.physics.PhysicsObject; 
import org.flashbacks.physics.colliders.PhysicsSphereCollider.PhysicsSphere;
import org.flashbacks.physics.solvers.PhysicsSmoothPositionSolver;
import openfl.geom.Vector3D;

class Main extends Sprite
{
    var isometricWorld:IsometricWorld;
    var physicsWorld:PhysicsWorld;
    var physicsTimer:Timer; 

    public function new()
    {
        // STAGE
        super();
        Lib.current.stage.frameRate = 300;
        addEventListener(Event.ENTER_FRAME, onEnterFrame); 
         
        // Set up physics timer
        physicsTimer = new Timer(42); // 24 FPS
        physicsTimer.run = onPhysicsTimerTick; 

        // ISOMETRIC
        isometricWorld = new IsometricWorld();
        addChild(isometricWorld);

        // PHYSICS
        physicsWorld = new PhysicsWorld();

        // Set up the spheres
        for (i in 1...1000) {
            var sphere = new PhysicsObject(1, new PhysicsSphere(new Vector3D(0, 0, 0), 8), new PhysicsTransform());
            sphere.transform.position.setTo(Math.random() * 7, 100, Math.random() * 7);
            sphere.force.x = Math.random() * 100;
            sphere.force.y = i;
            sphere.force.z = Math.random() * 100;
            physicsWorld.addObject(sphere);

            var tile = new TileBall();
            tile.position = sphere.transform.position;
            isometricWorld.addTile(tile);
        }

        // Set up the boxes
        for (x in 1...11) {
            for (z in 1...11) {
                // Calculate position for each box
                var posX:Float = x * 32;
                var posY:Float = 0; // You can adjust the height as needed
                var posZ:Float = z * 32;

                // Create a new PhysicsBox with the calculated position
                var box:PhysicsBox = new PhysicsBox(new Vector3D(16, 16, 16));
                var physicsObject:PhysicsObject = new PhysicsObject(1, box, new PhysicsTransform());
                physicsObject.transform.position.setTo(posX, posY, posZ);
                physicsObject.isDynamic = false;

                // Add the box to the physics world
                //physicsWorld.addObject(physicsObject);

                // Setup the tiel 
                var tile = new TileBasic();
                tile.position = physicsObject.transform.position;
                isometricWorld.addTile(tile);
            }
        }

        // Add physics solvers
        //physicsWorld.addSolver(PhysicsImpulseSolver.Solve);
        //physicsWorld.addSolver(PhysicsSmoothPositionSolver.Solve);
    }

    private function onEnterFrame(e:Event):Void { 
        isometricWorld.updateTilesOnTheSreen();   
    }

    private function onPhysicsTimerTick():Void{   
        physicsWorld.step(240/1000); 
    }
}
