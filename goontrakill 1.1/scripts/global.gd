
## beinhaltet globale variablen, auf die man von jededm skript leicht zugreifen kann

extends Node

var player_health : float = 6
var player_ammo : float
var dodge_cooldown : int = 1
var attack_cooldown: int = 1

signal bullet_hit 

# sind alle 3 bissel sketchy, geht vielleicht besser
signal pickup_entered
signal pickup_exited
signal buffUsed   # der ist am schlimmsten lowk
