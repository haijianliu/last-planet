//
//  SceneLoaderResourcesAvailableState.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/09.
//  Copyright © 2019 haijian. All rights reserved.
//

import GameplayKit

/**
A state used by `SceneLoader` to indicate that all of the resources for the scene are available.
*/
class SceneLoaderResourcesAvailableState: GKState {
	// MARK: Properties
	
	unowned let sceneLoader: SceneLoader
	
	// MARK: Initialization
	
	init(sceneLoader: SceneLoader) {
		self.sceneLoader = sceneLoader
	}
	
	// MARK: GKState Life Cycle
	
	override func isValidNextState(_ stateClass: AnyClass) -> Bool {
		switch stateClass {
		case is SceneLoaderInitialState.Type, is SceneLoaderPreparingResourcesState.Type:
			return true
			
		default:
			return false
		}
	}
}
