//
//  Input.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/14.
//  Copyright © 2019 haijian. All rights reserved.
//

import SpriteKit
import GameplayKit

public class Input: ControlInputSourceDelegate {
	
	static let sharedInstance = Input()
	private init() { }
	
	// MARK: Types
	
	struct InputState {
		var axis: float2?
		static let noInput = InputState()
	}
	
	// MARK: Properties
	
	static public var axis: float2? {
		get { return Input.sharedInstance.state.axis }
	}
	
	/**
	`InputComponent` has the ability to ignore input when disabled.
	
	This is used to prevent the player from moving or firing while
	being attacked.
	*/
	var isEnabled = true {
		didSet {
			if isEnabled {
				// Apply the current input state to the movement and beam components.
				applyInputState(state: state)
			}
			else {
				// Apply a state of no input to the movement and beam components.
				applyInputState(state: InputState.noInput)
			}
		}
	}
	
	var state = InputState() {
		didSet {
			if isEnabled {
				applyInputState(state: state)
			}
		}
	}
	
	// MARK: ControlInputSourceDelegate
	
	public func controlInputSource(_ controlInputSource: ControlInputSourceType, didUpdateAxis axis: float2?) {
		print(String(describing: type(of: self)) + " did update axis: " + String(describing: axis))
		
		state.axis = axis
	}
	
	// MARK: Convenience
	
	func applyInputState(state: InputState) {
//		if let component = entity?.component(ofType: TransformComponent.self) {
//			movementComponent.nextRotation = state.rotation
//			movementComponent.nextTranslation = state.translation
			
//			component.scale.x = -component.scale.x
//		}
	}
}
