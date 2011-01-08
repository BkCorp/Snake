//
//  HelloWorldLayer.m
//  Snake
//
//  Created by Kefan Xie on 11-01-07.
//  Copyright Home 2011. All rights reserved.
//

// Import the interfaces
#import "HelloWorldScene.h"

// HelloWorld implementation
@implementation HelloWorld

@synthesize snake = _snake;
@synthesize food = _food;
@synthesize scoreRect = _scoreRect;

+(id) scene
{
	CCScene *scene = [CCScene node];
	HelloWorld *layer = [HelloWorld node];
	[scene addChild: layer];
	return scene;
}

-(void) moveSnake:(int)x ycoord:(int)y direction:(int)d
{
	switch (d) {
		case 1:
			if (x > 10) x -= 20;
			break;
		case 2:
			if (y < 300) y += 20;
			break;
		case 3:
			if (x < 460) x+= 20;
			break;
		case 4:
			if (y > 10) y -= 20;
			break;
		default:
			break;
	}
	
	id actionMove = [CCMoveTo actionWithDuration:0.1 position:ccp(x, y)];
	[_snake runAction:actionMove];
	
	if (_snake.position.x == _food.position.x && _snake.position.y == _food.position.y)
	{
		_score++;
		[self removeChild:_food cleanup:YES];
		[self createNewFood];
		[self removeChild:_scoreRect cleanup:YES];
		[self loadScoreBoard];
	}
}

-(void) spriteMoveFinished:(id)sender {
	CCSprite *sprite = (CCSprite *)sender;
	[self removeChild:sprite cleanup:YES];
}

-(void) run:(ccTime)dt
{
	[self moveSnake:_snake.position.x ycoord:_snake.position.y direction:_direction];
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch* touch = [touches anyObject];
	touchOrigin = [touch locationInView:[touch view]];
	touchOrigin = [[CCDirector sharedDirector] convertToGL:touchOrigin];
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch* touch = [touches anyObject];
	touchStop = [touch locationInView:[touch view]];
	touchStop = [[CCDirector sharedDirector] convertToGL:touchStop];
	int dx = touchStop.x - touchOrigin.x;
	int dy = touchStop.y - touchOrigin.y;
	int tempDirection;

	if (abs(dy) * 0.50 > abs(dx))
	{
		if (dy < 0)
		{
			tempDirection = 4;
		}
		else
		{
			tempDirection = 2;
		}
	}
	else if (abs(dx) * 0.50 > abs(dy))
	{
		if (dx < 0)
		{
			tempDirection = 1;
		}
		else
		{
			tempDirection = 3;
		}
	}
	
	if (abs(tempDirection - _direction) != 2)
	{
		_direction = tempDirection;
	}
}

-(void) initSnake
{
	_snake = [CCSprite spriteWithFile:@"head.png" rect:CGRectMake(0, 0, 20, 20)];
	_snake.position = ccp(250, 170);
	[self addChild:_snake]; 
}

-(void) createNewFood {
	_food = [CCSprite spriteWithFile:@"food.png" rect:CGRectMake(0, 0, 20, 20)];
	_food.position = ccp(arc4random() % 23 * 20 + 10, arc4random() % 15 * 20 + 10);
	[self addChild:_food];
}

-(void) loadScoreBoard
{
	self.scoreRect = [CCLabelTTF 
					   labelWithString:[NSString stringWithFormat:@"%i", _score] 
					   dimensions: CGSizeMake(40, 20) 
					   alignment: UITextAlignmentLeft 
					   fontName:@"Arial" 
					   fontSize:20];	_scoreRect.color = ccc3(0, 0, 0);
	_scoreRect.position = ccp(40, 295);
	[self addChild:_scoreRect];
}

// on "init" you need to initialize your instance
-(id) init
{
	if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
		_direction = 1;
		_score = 0;
		self.isTouchEnabled = YES;
		
		[self initSnake];
		[self createNewFood];
		[self loadScoreBoard];
		
		[self schedule:@selector(run:) interval:0.12];

	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
	[_snake release];
	_snake = nil;
	[_grid release];
	_grid = nil;
	[_food release];
	_food = nil;
}
@end
