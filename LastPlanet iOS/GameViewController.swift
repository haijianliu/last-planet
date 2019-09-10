//
//  GameViewController.swift
//  LastPlanet iOS
//
//  Created by haijian on 2019/09/02.
//  Copyright © 2019 haijian. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import Engine

class GameViewController: UIViewController, SceneManagerDelegate {
	
	/// A manager for coordinating scene resources and presentation.
	var sceneManager: SceneManager!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Present the scene
		let skView = self.view as! SKView
		skView.ignoresSiblingOrder = true
		skView.showsFPS = true
		skView.showsNodeCount = true
		
		let gameInput = GameInput()
		sceneManager = SceneManager(presentingView: skView, gameInput: gameInput)
		sceneManager.delegate = self
		sceneManager.transitionToScene(sceneFileNamed: "GameScene")
	}
	
	override var shouldAutorotate: Bool {
		return true
	}
	
	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		if UIDevice.current.userInterfaceIdiom == .phone {
			return .allButUpsideDown
		} else {
			return .all
		}
	}
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	// MARK: SceneManagerDelegate
	
	func sceneManager(_ sceneManager: SceneManager, didTransitionTo scene: SKScene) {
		print("Did transition to scene: \(scene.self)")
	}
}
