//
//  ComponentSystem.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/04.
//  Copyright © 2019 haijian. All rights reserved.
//

import GameplayKit

public class ComponentSystem {
	
	static let sharedInstance = ComponentSystem()
	
	private var components = [GKComponentSystem<GKComponent>]()
	
	private init() {
		components.append(GKComponentSystem(componentClass: Transform.self))
	}
	
	static func add(gameObject: GameObject) {
		for component in ComponentSystem.sharedInstance.components { component.addComponent(foundIn: gameObject) }
	}
	
	public static func update(deltaTime: TimeInterval) {
		for component in ComponentSystem.sharedInstance.components { component.update(deltaTime: deltaTime) }
	}
}

