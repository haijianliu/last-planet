//
//  Input.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/14.
//  Copyright © 2019 haijian. All rights reserved.
//

public class Input {
	
	static let sharedInstance = Input()
	private init() { }
	
	// MARK: Properties
	
	static public func keyDown(_ keycode: Keycode) -> Float? {
		return Input.sharedInstance.keyDown[keycode.rawValue]
	}
	
	var keyDown = [Float?](repeating: nil, count: 256)
	
	// MARK: ControlInputSource
	
	func controlInputSource(didUpdateKey keycode: Int, for value: Float?) {
		keyDown[keycode] = value
	}
	
	func resetInputState() {
		keyDown = [Float?](repeating: nil, count: 256)
	}
}
