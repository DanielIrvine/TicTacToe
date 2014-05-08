#import <XCTest/XCTest.h>

@class DTISequenceGenerator;
@class DTIGameBoard;

@interface GameBoardTests : XCTestCase
{
    DTISequenceGenerator* _seqGen;
}

+(void)playSequence:(NSString*)sequence on:(DTIGameBoard*)board;

@end