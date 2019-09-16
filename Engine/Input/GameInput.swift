//
//  GameInput.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/14.
//  Copyright © 2019 haijian. All rights reserved.
//

import GameController

protocol GameInputDelegate: class {
	// Called whenever a control input source is updated.
	func gameInputDidUpdateControlInputSources(gameInput: GameInput)
}

/*
An abstraction representing game input for the user currently playing the game. Manages the control input sources, and handles game controller connections / disconnections.
*/
public class GameInput {
	// MARK: Properties
	
	#if os(tvOS)
	/**
	The control input source that is native to tvOS (gameController).
	This property is optional to represent that a game controller may not be
	immediately available upon launch.
	*/
	var nativeControlInputSource: ControlInputSourceType?
	#else
	/// The control input source that is native to the platform (keyboard or touch).
	let nativeControlInputSource: ControlInputSourceType
	#endif
	
//	/// An optional secondary input source for a connected game controller.
//	private(set) var secondaryControlInputSource: GameControllerInputSource?
//
//	var isGameControllerConnected: Bool {
//		var isGameControllerConnected = false
//		controlsQueue.sync {
//			isGameControllerConnected = (self.secondaryControlInputSource != nil) || (self.nativeControlInputSource is GameControllerInputSource)
//		}
//		return isGameControllerConnected
//	}
	
//	var controlInputSources: [ControlInputSourceType] {
//		// Return a non-optional array of `ControlInputSourceType`s.
//		let sources: [ControlInputSourceType?] = [nativeControlInputSource, secondaryControlInputSource]
//
//		return sources.flatMap { return $0 as ControlInputSourceType? }
//	}
	
	weak var delegate: GameInputDelegate? {
		didSet {
			// Ensure the delegate is aware of the player's current controls.
			delegate?.gameInputDidUpdateControlInputSources(gameInput: self)
		}
	}
	
	/// An internal queue to protect accessing the control input sources.
	private let controlsQueue = DispatchQueue(label: "com.engine.game.input.controlsqueue")
	
	// MARK: Initialization
	
	public init(nativeControlInputSource: ControlInputSourceType) {
		self.nativeControlInputSource = nativeControlInputSource
		
		self.nativeControlInputSource.delegate = Input.sharedInstance
		
		registerForGameControllerNotifications()
	}
	
	/// Register for `GCGameController` pairing notifications.
	func registerForGameControllerNotifications() {
		NotificationCenter.default.addObserver(self, selector: #selector(GameInput.handleControllerDidConnectNotification(notification:)), name: NSNotification.Name.GCControllerDidConnect, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(GameInput.handleControllerDidDisconnectNotification(notification:)), name: NSNotification.Name.GCControllerDidDisconnect, object: nil)
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self, name: NSNotification.Name.GCControllerDidConnect, object: nil)
		NotificationCenter.default.removeObserver(self, name: NSNotification.Name.GCControllerDidDisconnect, object: nil)
	}
	
	func update(withGameController gameController: GCController) {
		controlsQueue.sync {
			
			/*
			If not already assigned, add a game controller as the player's
			secondary control input source.
			*/
//			if self.secondaryControlInputSource == nil {
//				let gameControllerInputSource = GameControllerInputSource(gameController: gameController)
//				self.secondaryControlInputSource = gameControllerInputSource
//				gameController.playerIndex = .index1
//			}
		}
	}
	
	// MARK: GCGameController Notification Handling
	
	@objc func handleControllerDidConnectNotification(notification: NSNotification) {
//		let connectedGameController = notification.object as! GCController
//
//		update(withGameController: connectedGameController)
//		delegate?.gameInputDidUpdateControlInputSources(gameInput: self)
	}
	
	@objc func handleControllerDidDisconnectNotification(notification: NSNotification) {
//		let disconnectedGameController = notification.object as! GCController
//
//		// Check if the player was being controlled by the disconnected controller.
//		if secondaryControlInputSource?.gameController == disconnectedGameController {
//			controlsQueue.sync {
//				self.secondaryControlInputSource = nil
//			}
//
//			// Check for any other connected controllers.
//			if let gameController = GCController.controllers().first {
//				update(withGameController: gameController)
//			}
//
//			delegate?.gameInputDidUpdateControlInputSources(gameInput: self)
//		}
	}
}
