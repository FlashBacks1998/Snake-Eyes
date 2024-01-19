package org.flashbacks.physics;

import openfl.geom.Vector3D;

class PhysicsTransform {
    public var position:Vector3D;
    public var scale:Float;
    public var rotation:Vector3D;

    public function new(?position:Vector3D = null, ?scale:Float = null, ?rotation:Vector3D = null) {
        this.position = position != null ? position : new Vector3D();
        this.scale = scale != null ? scale : 1;
        this.rotation = rotation != null ? rotation : new Vector3D();
    }
}
