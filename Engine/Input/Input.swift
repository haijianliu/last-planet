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
	
	private var keyEvent = [Float?](repeating: nil, count: 256)
	
	static public func keyDown(_ keycode: Keycode) -> Float? {
		return Input.sharedInstance.keyEvent[keycode.rawValue]
	}
	
	// MARK: ControlInputSource
	
	func keyDown(with event: NSEvent) {
		keyEvent[Int(event.keyCode)] = 1.0
	}
	
	func keyUp(with event: NSEvent) {
		keyEvent[Int(event.keyCode)] = nil
	}
}
