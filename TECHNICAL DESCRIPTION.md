TECHNICAL DESCRIPTION.

This is a description of the class design and its tests.

  * This is an Objective-C project using the Sprite Kit framework. I have been writing Objective-C code for 3 months so I
    would still count myself as a newbie, and I haven't (yet) paid much attention to coding standards or stylistic elements.
    My code may appear to be very C#-like, which is the language I have most experience with.
  
  * Tests are written using the Appple XCode provided test library.
  
  * All classes are prefixed with the string DTI (my initials).

MAIN CODEBASE.

 * DTIGameBoard. This class is responsible for holding the current state of the game board and performing new moves on it.
   It also manages determining the next best move, which is a rule-based approach.
  
 * DTIComputerPlayerRule and its subtypes implement rules. These are run through in preference order until one of 
   the rules "chooses" to make a play.
   
   Most of these rules are fairly simple, but DTIForkRule and DTIBlockForkRule are fairly involved and nasty (see TODO).

 * DTIGameScene is the UI and manages graphical nodes, lines, and dialog boxes. 
 
 * DTIGame manages the interaction between DTIGameBoard and DTIGameScene. It maintains a score of how many games have been
   lost and drawn, and (cheekily) how many have been won but the count will never increase. It also manages resetting of
   games.
   
TESTS.

 * Tests have names in the form testWhenAThenB; A is a game state and then B is the action that is expected to occur.

 * In DTIGameBoardTests, each game board state is played out. Since I’ve used a rule-based approach to playing perfectly,
   testing is straightforward as each of the rules must be adhered to and can be tested.

 * Some DTIGameBoardTests use the DTISequenceGenerator class when there are a large number of game sequences to test;
   others use hardcoded sequence strings. All of these tests can take a string of the form “X—X—O” and set up the initial 
   game state using that, using a method called playSequence which converts this string representation to an actual 
   game board.

 * There are no tests for the view class, DTIGameScene. However, I’ve tried to keep this class to UI construction and
   input code only, with any logic performed in DTIGame. DTIGame has good coverage.
 
 
NOTE ON THE RULE-BASED SOLUTION.

I am aware that there is a minimax solution to this problem. When I set out to implement this I did not believe the
rule-based approach would be a huge amount of code, and I believed its advantages were:
 * that its requirements could be cleared captured as tests, making it easy to prove that the solution worked
 * that it would run much quicker than a minimax solution
 * that is would be simpler to randomize computer actions and make more enjoyable
 
In hindsight, the amount of code required for DTIForkRule and DTIBlockForkRule would cause me to reconsider using the
minimax alogorithm (see TODO).
