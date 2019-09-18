//
//  SceneKeyboardEventExtension.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/14.
//  Copyright © 2019 haijian. All rights reserved.
//

import Cocoa

/**
An extension of `Scene` to provide OS X platform specific functionality.
This file is only included in the OS X target.

Extend `Scene` to forward events from the scene to a platform-specific control input source.
On OS X, this is a `KeyboardControlInputSource`.
*/
extension Scene {
	
	// MARK: NSResponder
	
	override open func mouseDown(with event: NSEvent) {
		
	}
	
	override open func mouseUp(with event: NSEvent) {
		
	}
	
	override open func keyDown(with event: NSEvent) {
		Input.sharedInstance.keyDown(with: event)
	}
	
	override open func keyUp(with event: NSEvent) {
		Input.sharedInstance.keyUp(with: event)
	}
}
