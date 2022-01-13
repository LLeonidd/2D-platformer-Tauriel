extends Node

var fsm: StateMachine

func play_sound_sword_attack():
	var value_db_2 = -10
	fsm.audio.get_node('SwordAttack_2').play()

func enter():
	fsm.player.play('air_attack_close')
	#Play sound attack
	play_sound_sword_attack()
	yield(get_tree().create_timer(0.2), "timeout")
	exit('falling')


func exit(next_state):
	fsm.change_to(next_state)
	

func required_checked():
	if fsm.check_hit(): exit('hit')
	if fsm.player_root.dead_status: exit('dead')


func process(_delta):
	if Input.is_action_pressed(fsm.player_root.ui_right):
		fsm.player_root.velocity.x = fsm.get_direction(true)*fsm.player_root.SPEED
		fsm.set_direction(fsm.player, true)
	if Input.is_action_pressed(fsm.player_root.ui_left):
		fsm.player_root.velocity.x = fsm.get_direction(false)*fsm.player_root.SPEED
		fsm.set_direction(fsm.player, false)


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
