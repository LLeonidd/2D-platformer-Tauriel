extends Node

var fsm: StateMachineForGoblin


func enter():
	fsm.enemy_root.blood('show')
	fsm.enemy.play('hit')


func exit(next_state):
	fsm.change_to(next_state)



func process(_delta):
	pass


func physics_process(_delta):
	if not fsm.enemy_root.hit_status:
		#The status will change upon completion of the HIT animation 
		exit('run')

	
func input(_event):
	pass
	

func unhandled_input(_event):
	pass

func unhandled_key_input(_event):
	pass

func notification(_what, _flag = false):
	pass
