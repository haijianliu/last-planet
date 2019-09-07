//
//  AnimationState.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/07.
//  Copyright © 2019 haijian. All rights reserved.
//

/// The different animation states that an animated character can be in.
enum AnimationState: String {
	case idle = "Idle"
	case walkForward = "WalkForward"
	case walkBackward = "WalkBackward"
	case preAttack = "PreAttack"
	case attack = "Attack"
	case zapped = "Zapped"
	case hit = "Hit"
	case inactive = "Inactive"
}
