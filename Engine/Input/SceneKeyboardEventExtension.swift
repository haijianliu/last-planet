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
	// MARK: Properties
	
	var keyboardControlInputSource: KeyboardControlInputSource {
		return sceneManager.gameInput.nativeControlInputSource as! KeyboardControlInputSource
	}
	
	// MARK: NSResponder
	
	override open func mouseDown(with event: NSEvent) {
		keyboardControlInputSource.handleMouseDownEvent()
	}
	
	override open func mouseUp(with event: NSEvent) {
//		keyboardControlInputSource.handleMouseUpEvent()
	}
	
	override open func keyDown(with event: NSEvent) {
//		guard let characters = event.charactersIgnoringModifiers?.characters else { return }
//
//		for character in characters {
//			keyboardControlInputSource.handleKeyDown(forCharacter: character)
//		}
	}
	
	override open func keyUp(with event: NSEvent) {
//		guard let characters = event.charactersIgnoringModifiers?.characters else { return }
//
//		for character in characters {
//			keyboardControlInputSource.handleKeyUp(forCharacter: character)
//		}
	}
}
