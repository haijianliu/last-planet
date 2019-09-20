//
//  TransformComponent.swift
//  LastPlanet iOS
//
//  Created by haijian on 2019/09/04.
//  Copyright © 2019 haijian. All rights reserved.
//

import GameplayKit

public class TransformComponent: GKComponent {
	
	public var position = float3(repeating: 0)
	public var scale = float2(repeating: 1)
	
	private let unitToPixel: Float = 200.0
	
	override public func update(deltaTime seconds: TimeInterval) {
		super.update(deltaTime: seconds)
		
		print(String(describing: type(of: self)) + " \(seconds)")
		
		guard let node = entity?.component(ofType: GKSKNodeComponent.self)?.node else { return }
		
		if let spriteNode = node as? SKSpriteNode {
			spriteNode.texture?.filteringMode = .nearest
		}
	
		node.position = CGPoint(x: CGFloat(position.x * unitToPixel), y: CGFloat(position.y * unitToPixel))
		node.zPosition = CGFloat(position.z)

		node.xScale = CGFloat(scale.x)
		node.yScale = CGFloat(scale.y)
	}
}

