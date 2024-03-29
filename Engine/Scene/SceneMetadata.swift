//
//  SceneMetadata.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/08.
//  Copyright © 2019 haijian. All rights reserved.
//

/**
Encapsulates the metadata about a scene in the game.

A structure to encapsulate metadata about a scene in the game.
*/
struct SceneMetadata {
	// MARK: Properties
	
	/// The base file name to use when loading the scene and related resources.
	let fileName: String
	
	/// The type to use when loading this scene
	let sceneType: Scene.Type
	
	/// All on demand resources file names that pertain to the scene.
	let onDemandResourcesFileNames: Set<String>
	
	/// The list of types with resources that should be preloaded for this scene.
	let loadableTypes: [ResourceLoadableType.Type]
	
	/// A flag indicating whether the scene requires on demand resources to load.
	var requiresOnDemandResources: Bool {
		#if os(OSX)
		/*
		OS X does not use on demand resources, so resources will always be
		available on disk.
		*/
		return false
		#else
		/*
		Check for on demand resources, not all scenes have resources that
		need to be downloaded.
		*/
		return !onDemandResourcesFileNames.isEmpty
		#endif
	}
	
	// MARK: Initialization
	
	/// Initializes a new `SceneMetadata` instance from a dictionary.
	init(sceneConfiguration: [String: AnyObject]) {
		fileName = sceneConfiguration["fileName"] as! String
		
		let typeIdentifier = sceneConfiguration["sceneType"] as! String
		
		/// get 'anyClass' with classname and namespace
		let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
		
		/// get 'AnyClass' with class name and namespace
		guard let objectType = NSClassFromString("\(namespace).\(typeIdentifier)") else { fatalError("Unidentified sceneType requested") }
		
		guard let sceneType = objectType as? Scene.Type else { fatalError("Scene class must inherit `Engine.Scene` base class") }
		self.sceneType = sceneType
		
		
		var loadableTypesForScene = [ResourceLoadableType.Type]()
		
		// The on demand resource file names for the scene (if needed).
		if let fileNames = sceneConfiguration["onDemandResourcesFileNames"] as? [String] {
			onDemandResourcesFileNames = Set(fileNames)
			
			/*
			The tags are also used to determine which enemies need their resources
			to be preloaded for a `LevelScene`.
			*/
			loadableTypesForScene += fileNames.compactMap { name in
				/// get 'AnyClass' with class name and namespace
				guard let objectType = NSClassFromString("\(namespace).\(name)") else { return nil }
				guard let loadableType = objectType as? ResourceLoadableType.Type else { return nil }
				return loadableType
			}
		}
		else {
			onDemandResourcesFileNames = []
		}
		
		/*
		We will always need the `PlayerBot` and the `BeamNode`
		if the scene is a `LevelScene`, so add these `ResourceLoadableType`s
		by default.
		*/
//		if sceneType == LevelScene.self {
//			loadableTypesForScene = loadableTypesForScene + [PlayerBot.self, BeamNode.self]
//		}
//
		// Set up the `loadableTypes` to be prepared when the scene is requested.
		loadableTypes = loadableTypesForScene
	}
}
