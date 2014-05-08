//
//  DTIMyScene.h
//  TicTacToe
//

//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class DTIGame;
@class DTIPlayer;

@interface DTIGameScene : SKScene <UIAlertViewDelegate>
{
    NSArray* _backgroundGameNodes;

    DTIGame* _game;

    SKLabelNode* _won;
    SKLabelNode* _lost;
    SKLabelNode* _drawn;
    SKLabelNode* _youveLost;
    SKLabelNode* _youveDrawn;
    SKLabelNode* _betterLuck;
    SKLabelNode* _tapToPlay;

    UIAlertView* _newGameDialog;

    DTIPlayer* _nextPlayer;
}

@end
