//
//  GameObject.swift
//  LastPlanet iOS
//
//  Created by haijian on 2019/09/04.
//  Copyright © 2019 haijian. All rights reserved.
//

import GameplayKit

public class GameObject: GKEntity {
	override public func addComponent(_ component: GKComponent) {
		super.addComponent(component)
		ComponentSystem.addComponent(component)
	}
}

