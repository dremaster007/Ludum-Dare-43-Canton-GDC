extends Node

#0 = Easy | 1 = Decent | 2 = Hard | 3 = Insane | 4 = Hell
var current_difficulty = 0

#This will hold the size of the party, it will start at 4 [The player and 3 party members]
var party_size = 3

#This holds a dictionary that has each difficulty which holds the values of the levels that can be pulled into the game
var rooms = {"Easy": [], 
             "Decent": [],
             "Hard": [],
             "Insane": [],
             "Hell": []
            }
