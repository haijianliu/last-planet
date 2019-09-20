//
//  PlayerDuckState.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/20.
//  Copyright © 2019 haijian. All rights reserved.
//

import GameplayKit
import Engine

class PlayerDuckState: GKState {
	var entity: GKEntity?
	
	init(entity: GKEntity?) {
		self.entity = entity
		guard let animation = entity?.component(ofType: AnimationComponent.self) else { return }
		animation.addAnimation(named: "PlayerDuck")
	}
	
	override func didEnter(from previousState: GKState?) {
		print("Enter \(String(describing: self.self))")
		
		guard let animation = entity?.component(ofType: AnimationComponent.self) else { return }
		animation.requestedAnimationName = "PlayerDuck"
	}
	
	override func isValidNextState(_ stateClass: AnyClass) -> Bool {
		switch stateClass {
		case is PlayerRunShootState.Type,
				 is PlayerJumpState.Type,
				 is PlayerIdleState.Type:
			return true
		default:
			return false
		}
	}
	
	override func update(deltaTime seconds: TimeInterval) {
		guard let transform = entity?.component(ofType: TransformComponent.self) else { return }
		
		if let _ = Input.keyDown(Keycode.leftArrow) {
			transform.scale.x = -1.0
		}
		
		if let _ = Input.keyDown(Keycode.rightArrow) {
			transform.scale.x = 1.0
		}
		
		if let _ = Input.keyDown(Keycode.space) {
			stateMachine?.enter(PlayerJumpState.self)
			return
		}
		
		if Input.keyDown(Keycode.downArrow) == nil {
			stateMachine?.enter(PlayerIdleState.self)
		}
	}
}

