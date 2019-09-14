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
	
	private var updatables = [String: GKComponentSystem]()
	
	private init() {
		updatables[String(describing: TransformComponent.self)] = GKComponentSystem(componentClass: TransformComponent.self)
		updatables[String(describing: AnimationComponent.self)] = GKComponentSystem(componentClass: AnimationComponent.self)
	}
	
	static func addComponent(_ component: GKComponent) {
		ComponentSystem.sharedInstance.updatables[String(describing: type(of: component))]?.addComponent(component)
	}
	
	static func addComponent(foundIn entity: GKEntity) {
	for updatable in ComponentSystem.sharedInstance.updatables { updatable.value.addComponent(foundIn: entity) }
	}
	
	public static func update(deltaTime: TimeInterval) {
		for updatable in ComponentSystem.sharedInstance.updatables {
			DispatchQueue.main.async { updatable.value.update(deltaTime: deltaTime) }
		}
	}
}
