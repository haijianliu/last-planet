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
		
//		let scene = GameScene.newGameScene()
		
		// Present the scene
		let skView = self.view as! SKView
//		skView.presentScene(scene)
		
		skView.ignoresSiblingOrder = true
		
		skView.showsFPS = true
		skView.showsNodeCount = true
		
//		let url = Bundle.main.url(forResource: "SceneConfiguration", withExtension: "plist")
		
		let gameInput = GameInput()
		sceneManager = SceneManager(presentingView: skView, gameInput: gameInput)
		sceneManager.delegate = self
		sceneManager.transitionToScene(sceneFileNamed: "GameScene")
	}
	
	// MARK: SceneManagerDelegate
	
	func sceneManager(_ sceneManager: SceneManager, didTransitionTo scene: SKScene) {
		print("Did transition to scene: \(scene.self)")
	}
	
}
