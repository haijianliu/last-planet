//
//  LoadSceneOperation.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/09.
//  Copyright © 2019 haijian. All rights reserved.
//

/**
A subclass of `Operation` that manages the loading of a `BaseScene`.
*/
class LoadSceneOperation: SceneOperation, ProgressReporting {
	// MARK: Properties
	
	/// The metadata for the scene to load.
	let sceneMetadata: SceneMetadata
	
	/// The scene this operation is responsible for loading. Set after completion.
	var scene: Scene?
	
	/// Progress used to report on the status of this operation.
	let progress: Progress
	
	// MARK: Initialization
	
	init(sceneMetadata: SceneMetadata) {
		self.sceneMetadata = sceneMetadata
		
		progress = Progress(totalUnitCount: 1)
		super.init()
	}
	
	// MARK: NSOperation
	
	override func start() {
		// If the operation is cancelled there's nothing to do.
		guard !isCancelled else { return }
		
		if progress.isCancelled {
			// Ensure the operation is marked as `cancelled`.
			cancel()
			return
		}
		
		// Mark the operation as executing.
		state = .executing
		
		// Load the scene into memory using `SKNode(fileNamed:)`.
		let scene = sceneMetadata.sceneType.init(fileNamed: sceneMetadata.fileName)!
		
		// Set the scale mode to scale to fit the window
		scene.scaleMode = .aspectFill
		
		self.scene = scene
		
		// Set up the scene's camera and native size.
		//		scene.createCamera()
		
		// Update the progress object's completed unit count.
		progress.completedUnitCount = 1
		
		state = .finished
	}
}
