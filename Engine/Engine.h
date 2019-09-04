//
//  Engine.h
//  Engine
//
//  Created by haijian on 2019/09/03.
//  Copyright © 2019 haijian. All rights reserved.
//

#if defined(__APPLE__) && defined(__MACH__)
/* Apple OSX and iOS (Darwin) */
#include <TargetConditionals.h>

#if TARGET_IPHONE_SIMULATOR == 1
/* iOS in Xcode simulator */
#import <UIKit/UIKit.h>

#elif TARGET_OS_IPHONE == 1
/* iOS on iPhone, iPad, etc. */
#import <UIKit/UIKit.h>

#elif TARGET_OS_MAC == 1
/* OSX */
#import <Cocoa/Cocoa.h>

#endif
#endif

//! Project version number for Engine.
FOUNDATION_EXPORT double EngineVersionNumber;

//! Project version string for Engine.
FOUNDATION_EXPORT const unsigned char EngineVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <Engine/PublicHeader.h>
