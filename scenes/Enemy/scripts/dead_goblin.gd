extends Node

var fsm: StateMachineForGoblin


func enter():
	fsm.enemy_root.health_bar._on_health_update(0)
	fsm.enemy_root.show_blood()
	fsm.enemy.play('dead')


func exit(next_state):
	pass


func process(_delta):
	pass


func physics_process(_delta):
	pass

	
func input(_event):
	pass
	

func unhandled_input(_event):
	pass

func unhandled_key_input(_event):
	pass

func notification(_what, _flag = false):
	pass

