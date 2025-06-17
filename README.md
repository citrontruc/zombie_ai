# zombie_ai

## Description

A little project to implement a state machine and kinda complx behaviour.

We have a player and we have a "zombie" object. The player can move using the arrow keyus while the zombie has the following states:
- Wait (do nothing)
- Idle (walk for a second in a directory)
- Chase (walk towards player)

## Content

- main script (launch with lua love). Just go in the main directory and type :
```pwsh
love .
```
- assets (unused for now).
- player object to let our user control the player.
- graphics handler to handle the display of images.
- zombie contains all opur zombie states and a zombie factory to initialize the creation of a zombie object. 


## TODO

Use assets for our zombie graphics in order to move our zombie and our player. 
