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

var character_texs = {"Raea": "res://Assets/Graphics/Characters/raea.png",
                      "Hewer": "res://Assets/Graphics/Characters/hewer.png",
                      "Emily": "Insert path",
                      "Paul": "Insert path",
                      "ZachL": "Insert path",
                      "ZachS": "Insert path",
                      "Tony": "Insert path",
                      "James": "Insert path",
                      "Karel": "Insert path",
                      "Chris": "Insert path", 
                    }

var party = {"Player": character_texs.Raea,
             "Member1": character_texs.Hewer,
             "Member2": character_texs.Hewer,
             "Member3": character_texs.Hewer,
            }
# 1 = taken | 0 = empty
var inventory = {"Weapon": "None", "Item": "None"}