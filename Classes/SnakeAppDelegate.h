//
//  SnakeAppDelegate.h
//  Snake
//
//  Created by Kefan Xie on 11-01-07.
//  Copyright Home 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface SnakeAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
