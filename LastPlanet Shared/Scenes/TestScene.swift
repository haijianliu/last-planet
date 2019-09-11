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
	
	fileprivate var playerNode : SKSpriteNode?
	var player: GameObject?
	
	override func didMove(to view: SKView) {
		super.didMove(to: view)
		
		// Setup player entity with display and control components.
		player = GameObject()
		player?.addComponent(TransformComponent())
		player?.addComponent(SpriteComponent())
		
		self.playerNode = self.childNode(withName: "//SKSpriteNode") as? SKSpriteNode
		if let playerNode = self.playerNode {
			playerNode.texture?.filteringMode = .nearest
			playerNode.run(SKAction.init(named: "PlayerIdle")!, withKey: "somekey")
		}
	}
	
	override func update(_ currentTime: TimeInterval) {
		super.update(currentTime)
		
		ComponentSystem.update(deltaTime: deltaTime ?? 0)
		
		if let playerNode = self.playerNode {
			playerNode.texture?.filteringMode = .nearest
		}
	}
	
}
