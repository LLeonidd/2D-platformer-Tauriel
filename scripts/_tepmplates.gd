#Create object in add to scene
"""
var Player = preload("res://scenes/Player.tscn")
func _ready():
	create_payer()
func create_payer():
	var player = Player.instance()
	player.global_position = global_position #global posiotion in node2d
	player.set_as_toplevel(true)
	player.set_position(Vector2(0, 0))
	add_child(player)
	"""
