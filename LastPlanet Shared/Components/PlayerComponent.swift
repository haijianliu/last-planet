//
//  PlayerComponent.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/12.
//  Copyright © 2019 haijian. All rights reserved.
//

import GameplayKit
import Engine

class PlayerComponent: GKComponent, Updatable {
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
	
	override func update(deltaTime seconds: TimeInterval) {
		super.update(deltaTime: seconds)
		
		guard let component = entity?.component(ofType: TransformComponent.self) else { return }
		
		if Input.axis != nil {
			component.scale.x = -component.scale.x
		}
		
		if let _ = Input.keyDown(onKeycode: Keycode.j) {
			component.scale.x = -component.scale.x
		}
	}
}
