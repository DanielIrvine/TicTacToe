//
//  DTIWinRule.h
//  TicTacToe
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import "DTIComputerPlayerRule.h"

@class DTIPlayer;

@interface DTIRowOfTwoRule : DTIComputerPlayerRule {
    DTIPlayer* _playerToCheck;
}

-(id)initWithPlayerToCheck:(DTIPlayer*)playerToCheck
              andGameBoard:(DTIGameBoard*)board
                andSquares:(NSArray*)squares;

+(DTIRowOfTwoRule*)winRuleForBoard:(DTIGameBoard*)board
                        andSquares:(NSArray*)squares;

+(DTIRowOfTwoRule*)blockRuleForBoard:(DTIGameBoard*)board
                          andSquares:(NSArray*)squares;

@end
