tool
extends Character

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if Globals.courage >= 50:
		yield(E.run([
			'Pato: Ya no le daré más vueltas',
			'Pato: Voy con toda a hablarle a Lobo',
			C.walk_to_clicked(),
			C.player.face_right(),
			'...',
			'Pato: ...',
			'Pato: ........',
			'Pato: ......................',
			C.player.face_left(),
			'...',
			C.player.face_right(),
			'...',
			'Pato: Ho..... ho..... ho.....',
			A.play_music('mx_frolic'),
		]), 'completed')
		E.goto_room('End')
	else:
		E.run([
			C.face_clicked(),
			C.player_say('¡¡¡Ayyyy pero qué guapote!!!'),
			'Pato: Nunca seré capaz de hablarle',
			face_left(),
			C.face_clicked(),
			dance(),
			'Pato: Ayyyy... qué rico se mueve... \/( > __ < \\)'
		])


func on_look() -> void:
	E.run(['Pato: Está más bueno que el pan con chocolate'])


func on_item_used(item: Item) -> void:
	if item.script_name == 'Mopbrella':
			yield(E.run([
				C.player_say('Te salve de la desgracía Lobo de mis amores'),
			]), 'completed')
			A.stop('bg_dream_boat', 0, false)
			I.remove_item(item.script_name, false)
			A.play('sfx_dream_transition', Vector2.ZERO, false)
			E.goto_room('Bar')
	else:
		E.run([
			C.player_say('No alcanzo hasta allá'),
		])


func dance(is_in_queue := true) -> void:
	if is_in_queue: yield()
	$AnimationPlayer.play('dance_%s' % _looking_dir)
	yield(get_tree().create_timer(0.5), 'timeout')
