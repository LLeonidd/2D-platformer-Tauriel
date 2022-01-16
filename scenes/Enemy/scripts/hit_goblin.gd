extends Node

var fsm: StateMachineForGoblin


func enter():
	fsm.enemy_root.show_blood()
	fsm.enemy_root.health_bar._on_health_update(100-fsm.enemy_root.hit_counter*(100/fsm.enemy_root.MAX_NUMBER_HIT))
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
