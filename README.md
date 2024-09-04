# Cosy Farm Game [[unnamed]]

This is a repository containing my *work* on my cosy farm game.

It is made using **Godot**.

Bear in mind that this is the first game I am making using the engine, so this serves mostly as a way to learn for me and try to continue working on something.

I will try to continuously provide screenshots of the current status to make it more interesting!

- 2024-07-18
![Screenshot of the game](Screenshots/Screenshot%202024-07-18%20at%2021.27.58.png)

- 2024-09-04
![Screenshot of the game](Screenshots/Screenshot%202024-09-04%20at%2016.59.09.png)

---

**GAMEPLAY**
- [X] Initial setup (character movement + use a weapon + able to break and loot from trees and rocks + simple inventory + simple crafting + initial setup for cow AI)
- [X] Setup collision with water tiles
- [ ] Player
	- [X] Ability to hold an item
	- [X] Clarity on selected item in inventory
	- [ ] Ability to plant (depend on Plant)
- [ ] Cow
	- [X] Fix when cow is hit (doesn't slide forever)
	- [X] Fix direction of animation when moving
	- [X] Setup right animations depending on state
	- [ ] Refine current states constants
	- [ ] Add other states and animations 
		- [X] Follow Player (when player is holding food)
		- [ ] Sleeping
		- [X] Follow Player when he is holding food
    - [ ] Improve transition from different states to another
- [ ] Grass / Plant
	- [ ] Can grow
	- [ ] Link with cow eating pattern
