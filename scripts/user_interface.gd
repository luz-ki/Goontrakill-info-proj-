extends Control


func _ready():
	global.room_cleared.connect(tip)


func _process(delta: float):
	$TimeLabel.text = str("%.1f" % global.time_sec)

func tip():
	$YouWin/tipR.visible = true
