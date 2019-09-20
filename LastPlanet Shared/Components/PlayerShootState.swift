//
//  PlayerShootState.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/20.
//  Copyright © 2019 haijian. All rights reserved.
//

import GameplayKit
import Engine

class PlayerShootState: GKState {
	var entity: GKEntity?
	
	init(entity: GKEntity?) {
		self.entity = entity
		guard let animation = entity?.component(ofType: AnimationComponent.self) else { return }
		animation.addAnimation(named: "PlayerShoot")
	}
	
	override func didEnter(from previousState: GKState?) {
		print("Enter \(String(describing: self.self))")
		
		guard let animation = entity?.component(ofType: AnimationComponent.self) else { return }
		animation.requestedAnimationName = "PlayerShoot"
	}
	
	override func isValidNextState(_ stateClass: AnyClass) -> Bool {
		switch stateClass {
		case is PlayerRunShootState.Type,
				 is PlayerJumpState.Type,
				 is PlayerIdleState.Type,
				 is PlayerDuckState.Type:
			return true
		default:
			return false
		}
	}
	
	override func update(deltaTime seconds: TimeInterval) {
		if let _ = Input.keyDown(Keycode.leftArrow) {
			stateMachine?.enter(PlayerRunShootState.self)
			return
		}
		
		if let _ = Input.keyDown(Keycode.rightArrow) {
			stateMachine?.enter(PlayerRunShootState.self)
			return
		}
		
		if let _ = Input.keyDown(Keycode.space) {
			stateMachine?.enter(PlayerJumpState.self)
			return
		}
		
		if let _ = Input.keyDown(Keycode.downArrow) {
			stateMachine?.enter(PlayerDuckState.self)
		}
		
		guard let node = entity?.component(ofType: GKSKNodeComponent.self)?.node as? SKSpriteNode else { return }
		
		if node.action(forKey: "PlayerTextureAnimation") == nil {
			stateMachine?.enter(PlayerIdleState.self)
		}
	}
}

