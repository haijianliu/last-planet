//
//  ControlInputSource.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/14.
//  Copyright © 2019 haijian. All rights reserved.
//

import simd

/// Delegate methods for responding to control input that applies to the `PlayerBot`.
protocol ControlInputSourceDelegate: class {
	/**
	Update the `ControlInputSourceDelegate` with new displacement
	in a top down 2D coordinate system (x, y):
	Up:    (0.0, 1.0)
	Down:  (0.0, -1.0)
	Left:  (-1.0, 0.0)
	Right: (1.0, 0.0)
	*/
	func controlInputSource(_ controlInputSource: ControlInputSourceType, didUpdateAxis axis: float2?)
}

/// A protocol to be adopted by classes that provide control input and notify their delegates when input is available.
protocol ControlInputSourceType: class {
	/// A delegate that receives information about actions that apply to the entity.
	var delegate: ControlInputSourceDelegate? { get set }
	
	func resetControlState()
}

