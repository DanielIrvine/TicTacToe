TODO

This is a list of things I would do if I had more time:

- DTIPossibleMoveStore is now storing previously computed values and also rotating pieces; this should be separated out or possibly just renamed as the two functions are closely related.

- There is not much in the way of error handling. For example, DTIGame assumes that its game board is initialized when touchIn is called.

- Tests for DTIGame are good but not complete. For example, there are no tests for incrementing scores.

- Additional feature: draw a strikethrough line through a winning line.

- Additional feature: Text on the screen to show who is ‘X’ and who is ‘O’.

