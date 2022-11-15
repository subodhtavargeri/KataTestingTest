# Bowling - iOS

iOS app is an American Ten-Pin Bowling,which calculates total score of the game for given a valid sequence of rolls for one line of American Ten-Pin Bowling.


## Things that the program will not do
- We will not check for valid rolls.
- We will not check for correct number of rolls and frames.
- We will not provide scores for intermediate frames.

## Brief summarize the scoring for this form of bowling:
- Each game, or “line” of bowling, includes ten turns, or “frames” for the bowler.
- In each frame, the bowler gets up to two tries to knock down all the pins.
- If in two tries, he fails to knock them all down, his score for that frame is the total number of pins knocked down in his two tries.
- If in two tries he knocks them all down, this is called a “spare” and his score for the frame is ten plus the number of pins knocked down on his next throw (in his next turn).
- If on his first try in the frame he knocks down all the pins, this is called a “strike”. His turn is over, and his score for the frame is ten plus the simple total of the pins knocked down in his next two rolls.
- If he gets a spare or strike in the last (tenth) frame, the bowler gets to throw one or two more bonus balls, respectively. These bonus throws are taken as part of the same turn. If the bonus throws knock down all the pins, the process does not repeat: the bonus throws are only used to calculate the score of the final frame.
The game score is the total of all frame scores.

## Prerequisites

- Xcode (developed and tested on Xcode version 13.4.1)
- Simulator
- Tested for Iphone and Ipad.

## Run Application

- Open Bowling.xcodeproj uing Xcode (preferably 13.4.1).
- Run application on any Iphone/Ipad simulator.
