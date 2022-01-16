extends Control

export var normal_color = Color('2b9132')
export var warning_color = Color.orange
export var danger_color = Color.red
export var warning_val = 70
export var danger_val = 40


var hit_counter=2
var max_number_hit=3

onready var helth_bar = get_node("HealthBar")
onready var tween = get_node('Tween')

func _ready():
	helth_bar.value = 100
	#helth_bar.get("custom_styles/fg").set_bg_color(normal_color)
	helth_bar.set_tint_progress(normal_color)
	
func _get_new_color(value):
	if value <= danger_val:
		return danger_color
	elif value <= warning_val:
		return warning_color
	else:
		return normal_color
	

func _on_health_update(value):
	helth_bar.set_tint_progress(Color.white)
	var curent_val = helth_bar.get_value()
	var new_color = _get_new_color(value)
	tween.interpolate_method(helth_bar, "set_tint_progress", Color.white, new_color, .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_method(helth_bar, "set_value", curent_val, value, .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

