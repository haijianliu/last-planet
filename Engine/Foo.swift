//
//  Foo.swift
//  LastPlanet
//
//  Created by haijian on 2019/09/04.
//  Copyright © 2019 haijian. All rights reserved.
//

import Foundation

public class Foo {
	
	public class func bar() {
		#if os(OSX)
		print("I am Engine macOS 3.")
		#endif
		
		#if os(iOS)
		print("I am Engine iOS 3.")
		#endif
	}
}
