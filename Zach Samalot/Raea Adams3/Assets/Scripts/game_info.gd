extends Node

#0 = Easy | 1 = Decent | 2 = Hard | 3 = Insane | 4 = Hell
var current_difficulty = 0

#This will hold the size of the party, it will start at 4 [The player and 3 party members]
var party_size = 3

#This holds a dictionary that has each difficulty which holds the values of the levels that can be pulled into the game
var room_list = ["Room01", "Room02", "Room03"]

var character_texs = {"Raea": "res://Assets/Graphics/Characters/char_1_raea/Raea_spritesheet.png",
                      "Hewer": "res://Assets/Graphics/Characters/char_2_hubert/hewer.png",
                      "Emily": "res://Assets/Graphics/Characters/char_4_emily/Emily_spritesheet.png",
                      "Lawrence": "res://Assets/Graphics/Characters/char_3_lawrence/Lawerence_spritesheet.png",
                      "Zach": "res://Assets/Graphics/Characters/char_5_zach/Zach_spritesheet.png",
                      "Chris": "res://Assets/Graphics/Characters/char_6_chris/Chris_spritesheet.png",
                      "Pete": "res://Assets/Graphics/Characters/char_7_pete/Pete_forward_spritesheet.png",
                      "Shira": "res://Assets/Graphics/Characters/char_8_shira/Shira_spritesheet.png"
                    }

var party = {"Player": character_texs.Raea,
             "Member1": character_texs.Hewer,
             "Member2": character_texs.Hewer,
             "Member3": character_texs.Hewer,
            }
# 1 = taken | 0 = empty
var inventory = {"Weapon": "None", "Item": "None"}