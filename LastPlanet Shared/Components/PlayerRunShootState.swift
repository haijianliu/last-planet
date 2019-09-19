//
//  PlayerRunShootState.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/19.
//  Copyright © 2019 haijian. All rights reserved.
//

import GameplayKit
import Engine

class PlayerRunShootState: GKState {
	var entity: GKEntity?
	
	init(entity: GKEntity?) {
		self.entity = entity
		guard let animation = entity?.component(ofType: AnimationComponent.self) else { return }
		animation.addAnimation(named: "PlayerRunShoot")
	}
	
	override func didEnter(from previousState: GKState?) {
		print("Enter \(String(describing: self.self))")
		
		guard let animation = entity?.component(ofType: AnimationComponent.self) else { return }
		animation.requestedAnimationName = "PlayerRunShoot"
	}
	
	override func isValidNextState(_ stateClass: AnyClass) -> Bool {
		switch stateClass {
		case is PlayerIdleState.Type, is PlayerJumpState.Type:
			return true
		default:
			return false
		}
	}
	
	override func update(deltaTime seconds: TimeInterval) {
		guard let transform = entity?.component(ofType: TransformComponent.self) else { return }
		guard let player = entity?.component(ofType: PlayerComponent.self) else { return }
		
		var action = false
		
		if let _ = Input.keyDown(Keycode.leftArrow) {
			transform.position.x -= Float(player.speed * seconds * 200.0)
			transform.scale.x = -1.0
			action = true
		}
		
		if let _ = Input.keyDown(Keycode.rightArrow) {
			transform.position.x += Float(player.speed * seconds * 200.0)
			transform.scale.x = 1.0
			action = true
		}
		
		if let _ = Input.keyDown(Keycode.space) {
			stateMachine?.enter(PlayerJumpState.self)
			action = true
		}
		
		if !action {
			stateMachine?.enter(PlayerIdleState.self)
		}
	}
}
