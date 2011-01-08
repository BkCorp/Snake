//
//  HelloWorldLayer.h
//  Snake
//
//  Created by Kefan Xie on 11-01-07.
//  Copyright Home 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorld Layer
@interface HelloWorld : CCLayerColor
{
	NSMutableArray *_grid;
	CCSprite *_snake;
	CCSprite *_food;
	CGPoint touchOrigin;
	CGPoint touchStop;
	int _direction;
	int _score;
	CCLabelTTF *_scoreRect;
}
@property (retain) CCSprite *snake;
@property (retain) CCSprite *food;
@property (retain) CCLabelTTF *scoreRect;

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

@end
