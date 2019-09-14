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
		
		// Setup player entity with components.
		entity?.addComponent(TransformComponent())
		
		let animationComponent = AnimationComponent(ForActionKey: "PlayerTextureAnimation")
		animationComponent.addAnimation(named: "PlayerIdle")
		animationComponent.requestedAnimationName = "PlayerIdle"
		entity?.addComponent(animationComponent)
		
	}
}
