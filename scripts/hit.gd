extends Node

var fsm: StateMachine


func enter():
	fsm.player_root.show_blood()
	fsm.player.play('hit')


func exit(next_state):
	if next_state=='back':
		fsm.back()
	else:
		fsm.change_to(next_state)


func process(_delta):
	if not fsm.player_root.hit_status:
		exit('run')


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
