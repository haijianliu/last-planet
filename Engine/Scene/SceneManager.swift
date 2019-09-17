//
//  SceneManager.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/08.
//  Copyright © 2019 haijian. All rights reserved.
//

import SpriteKit

/**
`SceneManager` is responsible for presenting scenes, requesting future scenes be downloaded, and loading assets in the background.

A manager for presenting `BaseScene`s. This allows for the preloading of future levels while the player is in game to minimize the time spent between levels.
*/
public final class SceneManager {
	
	// MARK: Properties
	
	/// The view used to choreograph scene transitions.
	let presentingView: SKView
	
	/// The `SceneManager`'s delegate.
	public weak var delegate: SceneManagerDelegate?
	
	/// The scene that is currently being presented.
	private (set) var currentSceneMetadata: SceneMetadata?
	
	/// The scene used to indicate progress when additional content needs to be loaded.
//	private var progressScene: ProgressScene?
	
	/**
	A mapping of `SceneMetadata` instances to the resource requests
	responsible for accessing the necessary resources for those scenes.
	*/
	let sceneLoaders: [String: SceneLoader]
	
	/// Cached array of scene structure loaded from "SceneConfiguration.plist".
	private let sceneConfigurationInfo: [SceneMetadata]
	
	/// An object to act as the observer for `SceneLoaderDidCompleteNotification`s.
	private var loadingCompletedObserver: AnyObject?
	
	// MARK: Initialization
	
	/// Initialize scene manager with scene configuration file.
	///
	/// - Parameters:
	///   - url: `scene configuration plist`. This provides information about every scene in the game
	public init(forUrl url: URL, presentingView: SKView) {
		self.presentingView = presentingView
		
		/*
		Load the game's `SceneConfiguration` plist. This provides information
		about every scene in the game, and the order in which they should be displayed.
		*/
		let scenes = NSArray(contentsOf: url) as! [[String: AnyObject]]
		
		/*
		Extract the configuration info dictionary for each possible scene,
		and create a `SceneMetadata` instance from the contents of that dictionary.
		*/
		sceneConfigurationInfo = scenes.map {
			SceneMetadata(sceneConfiguration: $0)
		}
		
		// Map to `SceneLoader` for each possible scene.
		var sceneLoaders = [String: SceneLoader]()
		for metadata in sceneConfigurationInfo {
			sceneLoaders[metadata.fileName] = SceneLoader(sceneMetadata: metadata)
		}
		
		// Keep an immutable copy of the scene loader dictionary.
		self.sceneLoaders = sceneLoaders
		
		/*
		Because `SceneManager` is marked as `final` and cannot be subclassed,
		it is safe to register for notifications within the initializer.
		*/
		registerForNotifications()
	}
	
	deinit {
		// Unregister for `SceneLoader` notifications if the observer is still around.
		if let loadingCompletedObserver = loadingCompletedObserver {
			NotificationCenter.default.removeObserver(loadingCompletedObserver, name: NSNotification.Name.SceneLoaderDidCompleteNotification, object: nil)
		}
	}
	
	// MARK: Scene Transitioning
	
	/**
	Instructs the scene loader associated with the requested scene to begin preparing the scene's resources.
	
	This method should be called in preparation for the user needing to transition to the scene in order to minimize the amount of load time.
	*/
//	func prepareScene(sceneFileNamed fileName: String) {
//		guard let loader = sceneLoaders[fileName] else { fatalError("Unidentified scene file name requested") }
//		_ = loader.asynchronouslyLoadSceneForPresentation()
//	}
	
	/**
	Loads and presents a scene if the all the resources for the scene are currently in memory.
	
	Otherwise, presents a progress scene to monitor the progress of the resources being downloaded, or display an error if one has occurred.
	*/
	public func transitionToScene(sceneFileNamed fileName: String) {
		guard let loader = sceneLoaders[fileName] else { fatalError("Unidentified scene file name requested") }

		if loader.stateMachine.currentState is SceneLoaderResourcesReadyState {
			// The scene is ready to be displayed.
			presentScene(for: loader)
		}
		else {
			_ = loader.asynchronouslyLoadSceneForPresentation()

			/*
			Mark the `sceneLoader` as `requestedForPresentation` to automatically
			present the scene when loading completes.
			*/
			loader.requestedForPresentation = true

			// The scene requires a progress scene to be displayed while its resources are prepared.
			if loader.requiresProgressSceneForPreparing {
				presentProgressScene(for: loader)
			}
		}
	}
	
	// MARK: Scene Presentation
	
	/// Configures and presents a scene.
	func presentScene(for loader: SceneLoader) {
		guard let scene = loader.scene else {
			assertionFailure("Requested presentation for a `sceneLoader` without a valid `scene`.")
			return
		}
		
		// Hold on to a reference to the currently requested scene's metadata.
		currentSceneMetadata = loader.sceneMetadata
		
		// Ensure we present the scene on the main queue.
		DispatchQueue.main.async {
			/*
			Provide the scene with a reference to the `SceneLoadingManger`
			so that it can coordinate the next scene that should be loaded.
			*/
			scene.sceneManager = self
			
			// Present the scene with a transition.
//			let transition = SKTransition.fade(withDuration: GameplayConfiguration.SceneManager.transitionDuration)
//			self.presentingView.presentScene(scene, transition: transition)
			self.presentingView.presentScene(scene)
			
			/*
			When moving to a new scene in the game, we also start downloading
			on demand resources for any subsequent possible scenes.
			*/
			#if os(iOS) || os(tvOS)
			self.beginDownloadingNextPossibleScenes()
			#endif
			
			// Clear any reference to a progress scene that may have been presented.
//			self.progressScene = nil
			
			// Notify the delegate that the manager has presented a scene.
			self.delegate?.sceneManager(self, didTransitionTo: scene)
			
			// Restart the scene loading process.
			loader.stateMachine.enter(SceneLoaderInitialState.self)
		}
	}
	
	/// Configures the progress scene to show the progress of the `sceneLoader`.
	func presentProgressScene(for loader: SceneLoader) {
		// If the `progressScene` is already being displayed, there's nothing to do.
//		guard progressScene == nil else { return }
//
//		// Create a `ProgressScene` for the scene loader.
//		progressScene = ProgressScene.progressScene(withSceneLoader: loader)
//		progressScene!.sceneManager = self
//
//		let transition = SKTransition.doorsCloseHorizontal(withDuration: GameplayConfiguration.SceneManager.progressSceneTransitionDuration)
//		presentingView.presentScene(progressScene!, transition: transition)
	}
	
	#if os(iOS) || os(tvOS)
	/**
	Begins downloading on demand resources for all scenes that the user may reach next,
	and purges resources for any unreachable scenes that are no longer accessible.
	*/
	private func beginDownloadingNextPossibleScenes() {
		let possibleScenes = allPossibleNextScenes()
		
		for fileName in possibleScenes {
			let resourceRequest = sceneLoaders[fileName]!
			resourceRequest.downloadResourcesIfNecessary()
		}
		
		// Clean up scenes that are no longer accessible.
//		var unreachableSceneFileNames = Set(sceneLoaders.keys)
//		unreachableSceneFileNames.subtract(possibleScenes)
//
//		for fileName in unreachableSceneFileNames {
//			let resourceRequest = sceneLoaders[fileName]!
//			resourceRequest.purgeResources()
//		}
	}
	#endif
	
	/// Determines all possible scenes that the player may reach after the current scene.
	private func allPossibleNextScenes() -> Set<String> {
		let homeScene = sceneConfigurationInfo.first!
		
		// If there is no current scene, we can only go to the home scene.
		guard let currentSceneMetadata = currentSceneMetadata else { return [homeScene.fileName] }
		return currentSceneMetadata.onDemandResourcesFileNames
	}
	
	// MARK: SceneLoader Notifications
	
	/// Register for notifications of `SceneLoader` download completion.
	func registerForNotifications() {
		// Avoid reregistering for the notification.
		guard loadingCompletedObserver == nil else { return }
		
		loadingCompletedObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.SceneLoaderDidCompleteNotification, object: nil, queue: OperationQueue.main) { [unowned self] notification in
			let sceneLoader = notification.object as! SceneLoader
			
			// Ensure this is a `sceneLoader` managed by this `SceneManager`.
			guard let managedSceneLoader = self.sceneLoaders[sceneLoader.sceneMetadata.fileName], managedSceneLoader === sceneLoader else { return }
			
			guard sceneLoader.stateMachine.currentState is SceneLoaderResourcesReadyState else {
				fatalError("Received complete notification, but the `stateMachine`'s current state is not ready.")
			}
			
			/*
			If the `sceneLoader` associated with this state has been requested for presentation than we will present it here.
			*/
			if sceneLoader.requestedForPresentation {
				self.presentScene(for: sceneLoader)
			}
			
			// Reset the scene loader's presentation preference.
			sceneLoader.requestedForPresentation = false
		}
	}
}

