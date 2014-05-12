//
//  DTIMyScene.m
//  TicTacToe
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import "DTIGameScene.h"
#import "DTIGame.h"
#import "DTIPlayer.h"

static const NSInteger kMargin = 10;
static NSString* kFont = @"AmericanTypewriter-Bold";
static NSString* kSquareFont = @"Chalkduster";

@implementation DTIGameScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {

        self.backgroundColor = [SKColor blackColor];

        [self createDialog];
        [self drawGridLines];
        [self drawBackgroundNodes];
        [self drawTextHeadingsAndScores];
        [self drawResultLabels];

         _game = [[DTIGame alloc] init];
        [self promptForNewGame];
    }
    return self;
}

-(void)updateAfterPlay
{
    for( NSNumber* square in [_game getPlaysInOrder] )
    {
        [self createPlayedNodeFor:_nextPlayer
                               at:square.integerValue];
        _nextPlayer = [_nextPlayer opponent];
    }

    if( _game.isDrawn )
    {
        _drawn.text = [@(_game.drawn) stringValue];
        [self showDrawnResult];
    }
    else if( _game.isLost )
    {
        _lost.text = [@(_game.lost) stringValue];
        [self showLostResult];
    }
    // TODO: draw strikethrough line
}

-(void)createPlayedNodeFor:(DTIPlayer*)player
                           at:(NSInteger)position
{
    SKSpriteNode* parent = _backgroundGameNodes[position];
    SKLabelNode* label = [SKLabelNode labelNodeWithFontNamed:kSquareFont];
    label.text = player.description;
    label.fontSize = 40;
    label.position = CGPointMake(parent.size.width / 2, parent.size.height / 2);
    [_backgroundGameNodes[position] addChild:label];
}

-(void)drawTextHeadingsAndScores
{
    CGFloat leftPoint = self.size.width / 4;
    CGFloat midPoint = self.size.width / 2;
    CGFloat rightPoint = midPoint + leftPoint;
    [self drawTextHeading:@"Won" atX:leftPoint];
    [self drawTextHeading:@"Lost" atX:midPoint];
    [self drawTextHeading:@"Drawn" atX:rightPoint];

    _won = [self drawScoreAtX:leftPoint];
    _lost = [self drawScoreAtX:midPoint];
    _drawn = [self drawScoreAtX:rightPoint];
}

-(void)drawTextHeading:(NSString*)heading
                    atX:(CGFloat)xPosition
{
    SKLabelNode* label = [SKLabelNode labelNodeWithFontNamed:kFont];
    label.text = heading;
    label.fontSize = 20;
    label.fontColor = [SKColor greenColor];
    label.position = CGPointMake(xPosition, self.size.height - 40);
    [self addChild:label];
}

-(SKLabelNode*)drawScoreAtX:(CGFloat)xPosition
{
    SKLabelNode* label = [SKLabelNode labelNodeWithFontNamed:kFont];
    label.text = @"0";
    label.fontSize = 15;
    label.fontColor = [SKColor yellowColor];
    label.position = CGPointMake(xPosition, self.size.height - 60);
    [self addChild:label];
    return label;
}

-(void)drawResultLabels
{
    _youveDrawn = [self drawResult:@"You've drawn" atY:60 size:20];
    _youveLost = [self drawResult:@"You've lost" atY:60 size:20];
    _betterLuck = [self drawResult:@"Better luck next time!" atY:30 size:15];
    _tapToPlay = [self drawResult:@"Tap to play again" atY:10 size:10];
}

-(void)hideResultLabels
{
    _youveDrawn.hidden = true;
    _youveLost.hidden = true;
    _betterLuck.hidden = true;
    _tapToPlay.hidden = true;
}

-(void)showDrawnResult
{
    _youveDrawn.hidden = false;
    _betterLuck.hidden = false;
    _tapToPlay.hidden = false;
}

-(void)showLostResult
{
    _youveLost.hidden = false;
    _betterLuck.hidden = false;
    _tapToPlay.hidden = false;
}

-(SKLabelNode*)drawResult:(NSString*)text
                      atY:(CGFloat)yPosition
                     size:(NSInteger)size
{
    SKLabelNode* label = [SKLabelNode labelNodeWithFontNamed:kFont];
    label.text = text;
    label.fontSize = size;
    label.fontColor = [SKColor orangeColor];
    label.position = CGPointMake(self.size.width / 2, yPosition);
    label.hidden = true;
    [self addChild:label];
    return label;
}


-(void)reset
{
    for( SKNode* node in _backgroundGameNodes )
    {
        [node removeAllChildren];
    }

    _nextPlayer = _game.x;

    [self hideResultLabels];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(![_game isInPlay])
    {
        [self promptForNewGame];
    }
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];

        if([self nodeHasNotYetBeenPlayed:node])
        {
            NSInteger square = [_backgroundGameNodes indexOfObject:node];
            if( square != NSNotFound )
            {
                [_game touchIn:square];
            }
            else
            {
                [_game touchOutsideSquare];
            }
            [self updateAfterPlay];
        }
    }
}

-(bool)nodeHasNotYetBeenPlayed:(SKNode*)node
{
    return [node children].count == 0;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

-(void)drawBackgroundNodes
{
    CGFloat width = [self calculateBoardSize];
    CGFloat squareSize = width / 3;
    CGFloat bottom = (self.size.height - width) / 2;

    CGSize nodeSize = CGSizeMake(squareSize, squareSize);

    // It's important that the nodes get added to this array in
    // order as the index is used as the square number that's
    // passed to Game and GameBoard
    NSMutableArray* allNodes = [[NSMutableArray alloc] init];
    for(int i = 0; i < 9; ++i)
    {
        CGFloat left = (i % 3) * squareSize + kMargin;
        CGFloat top = (2 - (int)(i / 3)) * squareSize + bottom;
        [allNodes addObject:[self addBackgroundNode:left :top :nodeSize]];
    }
    _backgroundGameNodes = allNodes;
}

-(SKNode*)addBackgroundNode:(CGFloat)left :(CGFloat)top :(CGSize)size
{
    // A sprite node is used here because it has a size.
    // Other types of node don't.
    SKSpriteNode* back = [[SKSpriteNode alloc] init];
    back.position = CGPointMake(left, top);
    back.size = size;
    back.anchorPoint = CGPointMake(0,0);
    [self addChild:back];
    return back;
}

-(void)drawGridLines
{
    CGFloat width = [self calculateBoardSize];
    CGFloat squareSize = width / 3;
    CGFloat bottom = (self.size.height - width) / 2;
    CGFloat top = bottom + width;
    CGFloat left = kMargin;
    CGFloat right = self.size.width - kMargin;

    for( int i = 1; i < 3; ++i )
    {
        CGFloat y = bottom + squareSize * i;
        [self addGridLine:left:y:right:y];

        CGFloat x = kMargin + squareSize * i;
        [self addGridLine:x:top:x:bottom];
    }

}

-(void)addGridLine:(CGFloat)x1 :(CGFloat)y1 :(CGFloat)x2 :(CGFloat)y2
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, x1, y1);
    CGPathAddLineToPoint(path, nil, x2, y2);
    SKShapeNode* line = [[SKShapeNode alloc] init];
    line.path = path;
    line.strokeColor = [SKColor grayColor];
    line.lineWidth = 2;
    [self addChild:line];
}

-(CGFloat)calculateBoardSize
{
    // Width will be smaller than height so use that.
    return self.size.width - kMargin;
}

-(void)createDialog
{
    _newGameDialog = [[UIAlertView alloc] initWithTitle:@"New game"
                                                message:@"Would you like to play first?"
                                               delegate:self
                                      cancelButtonTitle:nil
                                      otherButtonTitles:@"Play first",@"Play second",nil];
}

-(void)promptForNewGame
{
    [_newGameDialog show];
}

// Note this alertView only gets called for the newGameDialog
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if( alertView == _newGameDialog )
    {
        [self reset];

        NSString *title = [alertView buttonTitleAtIndex:buttonIndex];

        if([title isEqualToString:@"Play second"])
        {
            [_game resetWithComputerFirst];
            [self updateAfterPlay];
        }
        else
        {
            [_game resetWithPlayerFirst];
        }
    }
}

@end
