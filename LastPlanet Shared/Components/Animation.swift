//
//  Animation.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/07.
//  Copyright © 2019 haijian. All rights reserved.
//

import SpriteKit

/**
Encapsulates all of the information needed to animate an entity and its shadow
for a given animation state and facing direction.
*/
struct Animation {
	
	// MARK: Properties
	
	/// The animation state represented in this animation.
	let animationState: AnimationState
	
	/// The direction the entity is facing during this animation.
	let compassDirection: CompassDirection
	
	/// One or more `SKTexture`s to animate as a cycle for this animation.
	let textures: [SKTexture]
	
	/**
	The offset into the `textures` array to use as the first frame of the animation.
	Defaults to zero, but will be updated if a copy of this animation decides to offset
	the starting frame to continue smoothly from the end of a previous animation.
	*/
	var frameOffset = 0
	
	/**
	An array of textures that runs from the animation's `frameOffset` to its end,
	followed by the textures from its start to just before the `frameOffset`.
	*/
	var offsetTextures: [SKTexture] {
		if frameOffset == 0 {
			return textures
		}
		let offsetToEnd = Array(textures[frameOffset..<textures.count])
		let startToBeforeOffset = textures[0..<frameOffset]
		return offsetToEnd + startToBeforeOffset
	}
	
	/// Whether this action's `textures` array should be repeated forever when animated.
	let repeatTexturesForever: Bool
	
	/// The name of an optional action for this entity's body, loaded from an action file.
	let bodyActionName: String?
	
	/// The optional action for this entity's body, loaded from an action file.
	let bodyAction: SKAction?
	
	/// The name of an optional action for this entity's shadow, loaded from an action file.
	let shadowActionName: String?
	
	/// The optional action for this entity's shadow, loaded from an action file.
	let shadowAction: SKAction?
}
