
## beinhaltet globale variablen, auf die man von jededm skript leicht zugreifen kann

extends Node

## variablen fur den spielercharkter
var player_position:Vector2
var player_max_health : int = 3  # nutzlich? idk lowkey
var player_health : int = 3
var dodge_cooldown : int = 1
var attack_cooldown: float = 1

var time_sec : float 
var time_min : float = 1.0
var time_h : float = 1.0
#var time := str("%0.f" % time_h + "."+"%0.f" %time_min +"."+ "%1.f" %time_sec) # ganz komisch

##signale, die infos und ereignisse zwischen nodes einfacg ermoglichen
signal bullet_hit   # variable fur den player bullet
signal player_hurt
signal player_died 
signal room_completed
signal room_cleared

var tipE_visible : bool = false
var areaTouching = false  # fur buffs, braucht REWORK!
var portalTouching = false
