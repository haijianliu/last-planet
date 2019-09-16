//
//  KeyboardControlInputSource.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/14.
//  Copyright © 2019 haijian. All rights reserved.
//

import simd

/**
An implementation of the `ControlInputSourceType` protocol that enables support for keyboard input on OS X.
*/
public class KeyboardControlInputSource: ControlInputSourceType {
	
	public init() {	}
	// MARK: Properties
	
	weak public var delegate: ControlInputSourceDelegate?
	
	public func resetControlState() {
		delegate?.controlInputSource(self, didUpdateAxis: nil)
	}
	
	// MARK: Control Handling
	
	func handleMouseDownEvent() {
		delegate?.controlInputSource(self, didUpdateAxis: float2(x: 0, y: 0))
	}
	
	func handleMouseUpEvent() {
		delegate?.controlInputSource(self, didUpdateAxis: nil)
	}
	
	/// The logic matching a key press to `ControlInputSourceDelegate` calls.
	func handleKeyDown(forCharacter character: Character) {

	}
	
	// Handle the logic matching when a key is released to `ControlInputSource` delegate calls.
	func handleKeyUp(forCharacter character: Character) {

	}
}
