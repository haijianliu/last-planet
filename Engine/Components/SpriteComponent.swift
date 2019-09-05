//
//  SpriteComponent.swift
//  LastPlanet iOS
//
//  Created by haijian on 2019/09/04.
//  Copyright © 2019 haijian. All rights reserved.
//

import GameplayKit

public class SpriteComponent: GKComponent {
	
	var node: SKNode?
	
	override public func update(deltaTime seconds: TimeInterval) {
		print(String(describing: type(of: self)) + " \(seconds)")
	}
}
