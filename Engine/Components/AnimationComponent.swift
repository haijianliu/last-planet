//
//  AnimationComponent.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/07.
//  Copyright © 2019 haijian. All rights reserved.
//

import SpriteKit
import GameplayKit

/**
Encapsulates all of the information needed to animate an entity.
*/
struct Animation {
	
	// MARK: Properties
	
	/// The name of an action for this entity, loaded from an action file.
	let actionName: String
	
	/// The action for this entity, loaded from an action file.
	let action: SKAction
}

/**
A `GKComponent` that provides and manages the actions used to animate entity on screen. `AnimationComponent` is supported by a structure called `Animation` that encapsulates information about an individual animation.
*/
public class AnimationComponent: GKComponent {
	
	// MARK: Properties
	
	/**
	The most recent animation name that the animation component has been requested to play,
	but has not yet started playing.
	*/
	public var requestedAnimationName: String?
	
	/// The animation that is currently running.
	private var currentAnimation: Animation?
	
	/// The key to use when adding an action to the entity.
	private let actionKey: String
	
	/// The current set of animations for the component's entity.
	private var animations = [String: Animation]()
	
	// MARK: Initializers
	
	public init(ForActionKey actionKey: String) {
		self.actionKey = actionKey
		super.init()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: GKComponent Life Cycle
	
	public override func update(deltaTime seconds: TimeInterval) {
		super.update(deltaTime: seconds)
		
		print(String(describing: type(of: self)) + " \(seconds)")
		
		// If an animation has been requested, run the animation.
		if let animationName = requestedAnimationName {
			runAnimation(forName: animationName)
			requestedAnimationName = nil
		}
	}
	
	// MARK: Animation
	
	public func addAnimation(named name: String) {
		guard let action = SKAction(named: name) else { return }
		animations[name] = Animation(actionName: name, action: action)
	}
	
	private func runAnimation(forName animationName: String) {
		
		guard let node = entity?.component(ofType: GKSKNodeComponent.self)?.node as? SKSpriteNode else { fatalError("An AnimationComponent's entity must have an SKSpriteNode GKSKNodeComponent.") }
		
		// Check if we are already running this animation. There's no need to do anything if so.
		if currentAnimation != nil && currentAnimation!.actionName == animationName { return }
		
		/*
		Retrieve a copy of the stored animation for the requested name.
		`Animation` is a structure - i.e. a value type - so the `animation` variable below will contain a unique copy of the animation's data.
		So that the `animation` variable's properties can be modified later.
		*/
		guard let unwrappedAnimation = animations[animationName] else {
			print("Unknown animation for name \(animationName).")
			return
		}
		let animation = unwrappedAnimation
		
		// Check if the action for the node has changed.
		if currentAnimation?.actionName != animation.actionName {
			// Remove the existing action if it exists.
			node.removeAction(forKey: actionKey)
			
			// Reset the node's position in its parent (it may have been animating with a move action).
//			node.position = CGPoint.zero
			
			// Add the new action to the node if an action exists.
			node.run(SKAction.repeatForever(animation.action), withKey: actionKey)
			
			print("Run animation: <\(Animation.self)> name: `\(animation.actionName)` action: \(animation.action)")
		}
		
		// Remember the animation currently running.
		currentAnimation = animation
	}
	
}
