extends Control

var view_port_width
var view_port_height



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(delta):
	view_port_width = get_viewport().get_size()[0]
	view_port_height = get_viewport().get_size()[1]

	
	

