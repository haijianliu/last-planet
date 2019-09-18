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
	
	// Parameter
	var hp: Float = 100.0
	var gravity: Float = 9.8
	var speed = 1.0
	var jumpPower: Float = 4.0
	var shootColdDown: Float = 0.1
	var hurtColdDown: Float = 1.0
	var hurtFreeze: Float = 0.3
	var freezeColdDown: Float = 5.0
	var backSpeed: Float = 0.5
	var shootEnergy: Float = 20.0
	var energyRegain: Float = 20.0
	var bulletDamage: Float = 40.0
	
	// status
	var move: Bool = false
	var right: Bool = true
	var air: Bool = false
	var shoot: Bool = false
	var duck: Bool = false
	var hurt: Bool = false
	var freeze: Bool = false

	var verticalSpeed: Float = 0.0
	var shootDuration: Float = 0.2
	var deathDelay: Float = 1.0
	var gameOverDelay: Float = 3.0
	var lastGameOver: Float = 0
	var lastShoot: Float = 0
	var lastHurt: Float = 0
	var lastFreeze: Float = 0
	
	override func didAddToEntity() {
		super.didAddToEntity()
		
		// Setup player entity with components.
		entity?.addComponent(TransformComponent())
		
		let animationComponent = AnimationComponent(ForActionKey: "PlayerTextureAnimation")
		animationComponent.addAnimation(named: "PlayerIdle")
		animationComponent.addAnimation(named: "PlayerRunShoot")
		animationComponent.requestedAnimationName = "PlayerRunShoot"
		entity?.addComponent(animationComponent)
	}
	
	override func update(deltaTime seconds: TimeInterval) {
		super.update(deltaTime: seconds)
		
		guard let transform = entity?.component(ofType: TransformComponent.self) else { return }
		guard let animation = entity?.component(ofType: AnimationComponent.self) else { return }
		
		move = false
		
		if let _ = Input.keyDown(Keycode.leftArrow) {
			transform.position.x -= Float(speed * seconds * 200.0)
			right = false
			move = true
		}
		if let _ = Input.keyDown(Keycode.rightArrow) {
			transform.position.x += Float(speed * seconds * 200.0)
			right = true
			move = true
		}
		
		animation.requestedAnimationName = move ? "PlayerRunShoot" : "PlayerIdle"
		
		transform.scale.x = right ? 1.0 : -1.0
	}
}
