tool # FOR WORK GET CONFIGURATION WARNING
extends Control

var view_port_width
var view_port_height
var k
var x
var y

export var scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control.target = self

func _get_configuration_warning():
	var message=""
	if not scene:
		message = "TEXT WARNING"
	return message

func _process(delta):
	
	view_port_width = get_viewport().get_size()[0]
	view_port_height = get_viewport().get_size()[1]
	k = get_viewport_transform()*(get_global_transform()*Vector2(800,800))
	x = view_port_width-10*view_port_width/100
	y = view_port_height-300
	#print(get_global_transform())
	#$ControlRight/CanvasLayer/UpButton.set_global_position(Vector2(x, y))

	
	

