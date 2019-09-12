//
//  TestScene.swift
//  LastPlanet iOS
//
//  Created by haijian on 2019/09/11.
//  Copyright © 2019 haijian. All rights reserved.
//

import SpriteKit
import GameplayKit
import Engine

class TestScene: Scene {
	
	override func didMove(to view: SKView) {
		super.didMove(to: view)
		
		// Setup player entity with display and control components.
		
//		if let playerNode = childNode(withName: "//Player") as? SKSpriteNode {
//			playerNode.run(SKAction.init(named: "PlayerIdle")!, withKey: "somekey2")
//		}

	}
	
	override func update(_ currentTime: TimeInterval) {
		super.update(currentTime)
		
//		ComponentSystem.update(deltaTime: deltaTime ?? 0)
		
//		if let playerNode = self.playerNode {
//			playerNode.texture?.filteringMode = .nearest
//		}
		
//		if let playerNode = childNode(withName: "//Player") as? SKSpriteNode {
//			print(playerNode.action(forKey: "somekey2"))
//		}
		
//
//		print(playerNode?.entity)
	}
	
}
