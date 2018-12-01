extends Node

var current_difficulty = {"Easy": false, "Decent": false, "Hard": false, "Insane": false, "Hell": false}

var party_size = 4 #This will hold the size of the party, it will start at 4 [The player and 3 party members]

#This holds a dictionary that has each difficulty which holds the values of the levels that can be pulled into the game
var rooms = {"Easy": [], 
             "Decent": [],
             "Hard": [],
             "Insane": [],
             "Hell": []
            }
