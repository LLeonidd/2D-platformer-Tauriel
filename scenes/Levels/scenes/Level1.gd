extends Node2D

export var Player:PackedScene

func _ready():
	create_payer()



func create_payer():
	var player = Player.instance()
	player.global_position = global_position #global posiotion in node2d
	player.set_as_toplevel(true)
	player.set_position(Vector2(155, 930))
	add_child(player)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
