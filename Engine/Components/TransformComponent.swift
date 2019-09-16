//
//  TransformComponent.swift
//  LastPlanet iOS
//
//  Created by haijian on 2019/09/04.
//  Copyright © 2019 haijian. All rights reserved.
//

import GameplayKit

public class TransformComponent: GKComponent {
	
	public var position = float3(repeating: 0) {
		didSet { requestedPosition = self.position }
	}
	
	public var scale = float2(repeating: 1) {
		didSet { requestedScale = self.scale }
	}
	
	private var requestedPosition: float3?
	private var requestedScale: float2?
	
	override public func update(deltaTime seconds: TimeInterval) {
		super.update(deltaTime: seconds)
		
		print(String(describing: type(of: self)) + " \(seconds)")
		
		guard let node = entity?.component(ofType: GKSKNodeComponent.self)?.node else {
			return
		}
		
		if let position = requestedPosition {
			node.position = CGPoint(x: CGFloat(position.x), y: CGFloat(position.y))
			node.zPosition = CGFloat(position.z)
			requestedPosition = nil
		}

		if let scale = requestedScale {
			node.xScale = CGFloat(scale.x)
			node.yScale = CGFloat(scale.y)
			requestedScale = nil
		}
	}
}

