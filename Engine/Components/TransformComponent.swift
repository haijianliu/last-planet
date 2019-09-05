//
//  TransformComponent.swift
//  LastPlanet iOS
//
//  Created by haijian on 2019/09/04.
//  Copyright © 2019 haijian. All rights reserved.
//

import GameplayKit

public class TransformComponent: GKComponent {
	
	var position = float3(repeating: 0)
	
	override public func update(deltaTime seconds: TimeInterval) {
		print(seconds)
	}
}
