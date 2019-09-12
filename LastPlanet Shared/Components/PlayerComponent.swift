//
//  PlayerComponent.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/12.
//  Copyright © 2019 haijian. All rights reserved.
//

import GameplayKit
import Engine

class PlayerComponent: GKComponent {
	// MARK: Properties
	
	override func didAddToEntity() {
		super.didAddToEntity()
		
		entity?.addComponent(TransformComponent())
		
		if let node = entity?.component(ofType: GKSKNodeComponent.self)?.node as? SKSpriteNode {
			node.run(SKAction.init(named: "PlayerIdle")!, withKey: "somekey")
		}
	}
}
