//
//  UpdateComponent.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/16.
//  Copyright © 2019 haijian. All rights reserved.
//

import GameplayKit

public protocol Updatable: GKComponent {
	func update(deltaTime seconds: TimeInterval)
}
