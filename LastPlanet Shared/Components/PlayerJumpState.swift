//
//  PlayerJumpState.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/19.
//  Copyright © 2019 haijian. All rights reserved.
//

import GameplayKit
import Engine

class PlayerJumpState: GKState {
	var entity: GKEntity?
	
	init(entity: GKEntity?) {
		self.entity = entity
		guard let animation = entity?.component(ofType: AnimationComponent.self) else { return }
		animation.addAnimation(named: "PlayerJump")
	}
	
	override func didEnter(from previousState: GKState?) {
		print("Enter \(String(describing: self.self))")
		
		guard let animation = entity?.component(ofType: AnimationComponent.self) else { return }
		guard let player = entity?.component(ofType: PlayerComponent.self) else { return }

		animation.requestedAnimationName = "PlayerJump"
		player.verticalSpeed = player.jumpPower
	}
	
	override func isValidNextState(_ stateClass: AnyClass) -> Bool {
		switch stateClass {
		case is PlayerIdleState.Type, is PlayerRunShootState.Type:
			return true
		default:
			return false
		}
	}
	
	override func update(deltaTime seconds: TimeInterval) {
		guard let transform = entity?.component(ofType: TransformComponent.self) else { return }
		guard let player = entity?.component(ofType: PlayerComponent.self) else { return }
		
		if let _ = Input.keyDown(Keycode.leftArrow) {
			transform.position.x -= Float(player.speed * seconds)
			transform.scale.x = -1.0
		}
		
		if let _ = Input.keyDown(Keycode.rightArrow) {
			transform.position.x += Float(player.speed * seconds)
			transform.scale.x = 1.0
		}
		
		player.verticalSpeed -= player.gravity * Float(seconds)
		if player.verticalSpeed <= -0.8 * player.jumpPower {
			player.verticalSpeed = -0.8 * player.jumpPower
		}
		
		transform.position.y += player.verticalSpeed * Float(seconds)
		
		if transform.position.y < 0 {
			transform.position.y = 0
			stateMachine?.enter(PlayerIdleState.self)
		}
	}
}
