//
//  DepthOfFieldViewer.swift
//  DepthOfFieldExplorer
//
//  Created by Simon Gladman on 30/04/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import SceneKit

class DepthOfFieldViewer: SCNView
{
    let camera = SCNCamera()
    
    override func didMoveToSuperview()
    {
        
        antialiasingMode = SCNAntialiasingMode.Multisampling4X
        
        backgroundColor = UIColor(red: 0, green: 0, blue: 0.5, alpha: 1.0)
        layer.borderColor = UIColor.darkGrayColor().CGColor
        layer.borderWidth = 1
        
        let torus = SCNTorus(ringRadius: 8, pipeRadius: 2)
        torus.ringSegmentCount = 64
        
        var material: SCNMaterial = SCNMaterial()
        material.diffuse.contents = UIImage(named: "checkerboard.jpg")
        
        var floorMaterial: SCNMaterial = SCNMaterial()
        floorMaterial.diffuse.contents = UIImage(named: "grid.jpg")
        floorMaterial.diffuse.wrapS = SCNWrapMode.Repeat
        floorMaterial.diffuse.wrapT = SCNWrapMode.Repeat
        
        let thisScene = SCNScene()
        
        scene = thisScene
        
        // camera...
        
        camera.xFov = 60
        camera.yFov = 60
        
        let cameraNode = SCNNode()
        
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 0)
        
        thisScene.rootNode.addChildNode(cameraNode)
        
        // torus...
        
        createGeometry(torus, xPos: 0, yPos: 0, zPos: -20)
        createGeometry(torus, xPos: 10, yPos: 0, zPos: -40)
        createGeometry(torus, xPos: -10, yPos: 0, zPos: -60)
        createGeometry(torus, xPos: 0, yPos: 0, zPos: -80)
        
        torus.materials = [material]
        
        // ambient light...
        
        let ambientLight = SCNLight()
        ambientLight.type = SCNLightTypeAmbient
        ambientLight.color = UIColor(white: 0.15, alpha: 1.0)
        let ambientLightNode = SCNNode()
        ambientLightNode.light = ambientLight
        
        thisScene.rootNode.addChildNode(ambientLightNode)
        
        // omni light...
        
        let omniLight = SCNLight()
        omniLight.type = SCNLightTypeOmni
        omniLight.color = UIColor(white: 1.0, alpha: 1.0)
        let omniLightNode = SCNNode()
        omniLightNode.light = omniLight
        omniLightNode.position = SCNVector3(x: -5, y: 8, z: 20)
        
        thisScene.rootNode.addChildNode(omniLightNode)
        
        // floor...
        
        let floor = SCNFloor()
        createGeometry(floor, xPos: 0, yPos: -10, zPos: -50, wRot: 0)
        floor.materials = [floorMaterial]
    }
    
    func createGeometry(geometry: SCNGeometry, xPos: Float, yPos: Float, zPos: Float, wRot: Float = Float(M_PI))
    {
        let node = SCNNode(geometry: geometry)
        node.position = SCNVector3(x: xPos, y: yPos, z: zPos)
        node.rotation = SCNVector4(x: Float(0.0), y: Float(1.0), z: Float(1.0), w: wRot)
        scene?.rootNode.addChildNode(node)
    }
    
}