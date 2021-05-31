tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _ready() -> void:
	if C.player.last_room == 'Marrano' \
		and Globals.has_done(Globals.GameState.GARBAGE_THROWN):
		play('garbage_floating', false)
	else:
		play('SETUP', false)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if C.player.last_room == 'HomesPlantation':
		E.run([
			'Lobo: Nope',
			'Lobo: I won\'t trash our future home...'
			
		])
#	elif C.player.last_room == 'Marrano':
	else:
		if Globals.has_done(Globals.GameState.DOME_SPOTTED):
			if not Globals.has_done(Globals.GameState.GARBAGE_THROWN):
				yield(
					E.run([
					'Lobo: Here we go! DESTRUCTION TIME!!!!',
					A.play('sfx_spaceship_garbage', global_position),
					play('open'),
					'Pato: UUUUuuuUUUUuuuUUUuuu',
				]), 'completed')
				Globals.did(Globals.GameState.GARBAGE_THROWN)
				E.goto_room('Marrano')
			elif not Globals.has_done(Globals.GameState.WATER_TAKEN): 
				E.run([
					'Lobo: We don\'t have more trash...',
					'Lobo: Hurry up Pato! The pig will come back soon!'
				])
			else:
				E.run([
					'Lobo: What!? I have to teletransport Pato.'
				])
		else:
			E.run([
				'Lobo: I will not trash our trash to the cosmos.'
			])

func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass


func play(anim_name: String, is_in_queue := true) -> void:
	if is_in_queue: yield()
	
	$AnimationPlayer.play(anim_name)
	yield($AnimationPlayer, 'animation_finished')

