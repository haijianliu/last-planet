//
//  OrientationComponent.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/07.
//  Copyright © 2019 haijian. All rights reserved.
//

import SpriteKit
import GameplayKit

/**
A `GKComponent` that enables an animated entity to track its current orientation (i.e. the direction it is facing). This information is used when choosing an appropriate animation.
*/
class OrientationComponent: GKComponent {
	// MARK: Properties
	
	var zRotation: CGFloat = 0.0 {
		didSet {
			let twoPi = CGFloat(.pi * 2.0)
			zRotation = (zRotation + twoPi).truncatingRemainder(dividingBy: twoPi)
		}
	}
	
	var compassDirection: CompassDirection {
		get {
			return CompassDirection(zRotation: zRotation)
		}
		
		set {
			zRotation = newValue.zRotation
		}
	}
}
