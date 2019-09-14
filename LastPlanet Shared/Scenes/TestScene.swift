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
		
		if let player = self.childNode(withName: "//SKSpriteNode") as? SKSpriteNode {
			player.run(SKAction.init(named: "PlayerIdle")!, withKey: "PlayerTextureAction")
		}

	}
	
	override func update(_ currentTime: TimeInterval) {
		super.update(currentTime)
	}
	
}
