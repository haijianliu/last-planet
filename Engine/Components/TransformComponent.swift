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
	
	override public func didAddToEntity() {
		super.didAddToEntity()
		
		if let node = entity?.component(ofType: GKSKNodeComponent.self)?.node as? SKSpriteNode {
			node.texture?.filteringMode = .nearest
//			node.run(SKAction.init(named: "PlayerIdle")!, withKey: "somekey")
		}
	}
	
	override public func update(deltaTime seconds: TimeInterval) {
		super.update(deltaTime: seconds)
		
		print(String(describing: type(of: self)) + " \(seconds)")
		
		if let node = entity?.component(ofType: GKSKNodeComponent.self)?.node as? SKSpriteNode {
			node.position = CGPoint(x: CGFloat(position.x), y: CGFloat(position.y))
			node.zPosition = CGFloat(position.z)
//			print(node.action(forKey: "somekey")?.duration)
			
		}
	}
}

