# Tic-Tac-Toe
This is the first OOP-based Ruby project from The Odin Project's Full Stack Ruby on Rails curriculum

![alt text](game-sample.png?raw=true "screenshot of tic-tac-toe gameplay")

## Project objectives

1. Build a command line tic-tac-toe game where two human players can play against each other
2. Write tests for the tic-tac-toe game

## Motivation for this project

This is an excellent opportunity to put my newly learned OOP knowledge to the test. The project won't be easy, but the process of building this game will lead to a much better understanding of Ruby and OOP.

## Technologies used
<p align="left">
<a href="https://www.ruby-lang.org/en/" target="_blank" rel="noreferrer"> <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/ruby/ruby-original.svg" alt="ruby" width="40" height="40"/> </a>
<a href="https://rspec.info/" target="_blank" rel="noreferrer"> <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/rspec/rspec-original.svg" alt="rspec" width="40" height="40"/> </a> </p>

## Overview of the game
1. To begin, the board and the instructions for making moves are displayed
2. The first player is asked to enter their name, and then the symbol that they prefer (X or O)
3. The second player is asked to enter their name, and their symbol is assigned automatically (X if Player 1's symbol is O, and vice versa)
4. Both players' names and symbols are displayed on the screen
5. The game randomly chooses which player will go first
6. Until the game is won or tied, players are prompted to make a move and the updated board is displayed after every turn
7. If the game is won, the winner's name is declared and the game ends
8. If the game is tied, a sentence declaring the tie is printed and the game ends

## Overview of the tests
1. 31 tests
2. Most methods are tested, especially critical ones

## Challenges faced while building the game
### 1. Knowing where to begin
Since this was the first major project and first OOP-based project in the curriculum, starting off was a big challenge. A lot of time was spent staring at a blank slate with no idea about how to start or what to even start.

### 2. Switching turns during the game
In hindsight, this method was very simple and easy to implement. However, it took a lot of thought to come up with this method. Poor knowledge of Ruby (since this was my first big project) was likely the cause of this struggle.

## Challenges faced while writing the tests
1. Determining which methods to write tests for
2. RSpec syntax-related problems
3. Resolving errors for failing tests
4. Determining how to test certain methods
5. Ensuring methods were tested appropriately and sufficiently

## Room for improvement
1. After a game ends, give players the option to play again
2. Allow players to play a game of 'best of 3', 'best of 5', and so on
3. When a player wins, highlight the winning positions by adding color or other styling to the symbols
