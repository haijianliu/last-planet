//
//  PlayerIdleState.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/19.
//  Copyright © 2019 haijian. All rights reserved.
//

import GameplayKit
import Engine

class PlayerIdleState: GKState {
	var entity: GKEntity?

	init(entity: GKEntity?) {
		self.entity = entity
		guard let animation = entity?.component(ofType: AnimationComponent.self) else { return }
		animation.addAnimation(named: "PlayerIdle")
	}
	
	override func didEnter(from previousState: GKState?) {
		print("Enter \(String(describing: self.self))")
		
		guard let animation = entity?.component(ofType: AnimationComponent.self) else { return }
		animation.requestedAnimationName = "PlayerIdle"
	}
	
	override func isValidNextState(_ stateClass: AnyClass) -> Bool {
		switch stateClass {
		case is PlayerRunShootState.Type:
			return true
		default:
			return false
		}
	}
	
	override func update(deltaTime seconds: TimeInterval) {
		
	}
}