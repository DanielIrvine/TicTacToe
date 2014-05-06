//
//  DTIDrawSequenceGenerator.h
//  TicTacToe
//
//  Created by Daniel Irvine on 06/05/2014.
//  Copyright (c) 2014 Daniel Irvine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTISequenceGenerator : NSObject
{
    NSRange _regexRange;
    NSRegularExpression* _xRegex;
}

-(NSArray*)generateAllWinningSequences;
-(NSArray*)generateDrawSequences;
-(NSArray*)generateOneMoveFromWinningSequences;

@end
