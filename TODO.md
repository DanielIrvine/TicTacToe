TODO

This is a list of things I would do if I had more time:

- There is not much in the way of error handling. For example, DTIGame assumes that its game board is initialized when touchIn is called.

- Tests for DTIGame are good but not complete. For example, there are no tests for incrementing scores.

- Make the computer’s moves more random, which would increase player enjoyment (although of course, they will still lose.) For example, when choosing an empty square, all corners are of equal weight but DTIEmptySquareRule will always choose the first available cell that it checks from its array.

- DTIBlockForkRule and DTIForkRule are complicated; I think with some time they could probably be simplified.

- Possibly implement the minimax method.
   Advantage: much smaller codebase and therefore less chance of bugs and programmer error (!)
   Disadvantage: harder to test, possibly runs slower, may not be as fun without some play randomization.
   
- Additional feature: draw a strikethrough line through a winning line.

- Additional feature: Text on the screen to show who is ‘X’ and who is ‘O’.

