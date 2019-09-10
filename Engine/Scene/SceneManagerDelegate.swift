//
//  SceneManagerDelegate.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/10.
//  Copyright © 2019 haijian. All rights reserved.
//

import SpriteKit

public protocol SceneManagerDelegate: class {
	// Called whenever a scene manager has transitioned to a new scene.
	func sceneManager(_ sceneManager: SceneManager, didTransitionTo scene: SKScene)
}
