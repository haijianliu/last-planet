//
//  Updatable.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/04.
//  Copyright © 2019 haijian. All rights reserved.
//

/// Updatable Behaviour protocol updates Behavour every frame.
///
/// Requires that class inherits from Component
@objc protocol Updatable: Behaviour {
	
	/// Update is called every frame.
	/// In order to get the elapsed time since last call to Update, use Time.deltaTime. This function is only called if the Behaviour is enabled. Override this function in order to provide your component's functionality.
	func update()
}
