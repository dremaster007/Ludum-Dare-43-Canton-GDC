extends Node

#0 = Easy | 1 = Decent | 2 = Hard | 3 = Insane | 4 = Hell
var current_difficulty = 0

var setup = true

#This will hold the size of the party, it will start at 4 [The player and 3 party members]
var member1_dead = false
var member2_dead = false
var member3_dead = false

var room_count = 0

#This holds a dictionary that has each difficulty which holds the values of the levels that can be pulled into the game
var room_list = ["Room01","Room03", "Room04", "Room06", "Room07"]

var character_texs = {"Raea": "res://Assets/Graphics/Characters/char_1_raea/Raea_spritesheet.png",
                      "Hewer": "res://Assets/Graphics/Characters/char_2_hubert/hewer.png",
                      "Emily": "res://Assets/Graphics/Characters/char_4_emily/Emily_spritesheet.png",
                      "Lawrence": "res://Assets/Graphics/Characters/char_3_lawrence/Lawerence_spritesheet.png",
                      "Zach": "res://Assets/Graphics/Characters/char_5_zach/Zach_spritesheet.png",
                      "Chris": "res://Assets/Graphics/Characters/char_6_chris/Chris_spritesheet.png",
                      "Pete": "res://Assets/Graphics/Characters/char_7_pete/Pete_forward_spritesheet.png",
                      "Shira": "res://Assets/Graphics/Characters/char_8_shira/Shira_spritesheet.png"
                    }

var party_textures = {"Player": character_texs.Raea}

var party = {"Player": {"Texture": character_texs.Raea, "Max_HP": 0, "Current_HP": 10, "Attack": 0},
             "Member1": {"Texture": character_texs.Hewer, "Max_HP": 1, "Current_HP": 10, "Attack": 0},
             "Member2": {"Texture": character_texs.Hewer, "Max_HP": 0, "Current_HP": 10, "Attack": 0},
             "Member3": {"Texture": character_texs.Hewer, "Max_HP": 0, "Current_HP": 10, "Attack": 0}
            }
# 1 = taken | 0 = empty
var inventory = {"Weapon": "None", "Item": "None"}


var Health = 100# you can change this later or put a better funcion