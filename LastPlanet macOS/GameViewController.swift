//
//  GameViewController.swift
//  LastPlanet macOS
//
//  Created by haijian on 2019/09/02.
//  Copyright © 2019 haijian. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

import Engine

class GameViewController: NSViewController, SceneManagerDelegate {
	
	/// A manager for coordinating scene resources and presentation.
	var sceneManager: SceneManager!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Current view must be a spritekit view
		let skView = self.view as! SKView
		skView.ignoresSiblingOrder = true
		skView.showsFPS = true
		skView.showsNodeCount = true
		
		let gameInput = GameInput()
		/*
		Load the game's `SceneConfiguration` plist. This provides information
		about every scene in the game, and the order in which they should be displayed.
		*/
		let url = Bundle.main.url(forResource: "SceneConfiguration", withExtension: "plist")!
		sceneManager = SceneManager(forUrl: url, presentingView: skView, gameInput: gameInput)
		sceneManager.delegate = self
		sceneManager.transitionToScene(sceneFileNamed: "TestScene")
	}
	
	// MARK: SceneManagerDelegate
	
	func sceneManager(_ sceneManager: SceneManager, didTransitionTo scene: SKScene) {
		print("Did transition to scene: \(scene.self)")
	}
	
}
