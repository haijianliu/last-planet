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
		print(String(describing: type(of: self)) + " \(seconds)")
		
		if let sprite = entity?.component(ofType: SpriteComponent.self) {
			sprite.node?.position = CGPoint(x: CGFloat(position.x), y: CGFloat(position.y))
			sprite.node?.zPosition = CGFloat(position.z)
		}
	}
}
