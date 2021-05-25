tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if C.player.last_room == 'HomesPlantation':
		E.run([
			'...',
			'Lobo: I won\'t trash our future home...'
			
		])
	elif C.player.last_room == 'Marrano':
		if Globals.has_done(Globals.GameState.DOME_SPOTTED):
			if not Globals.has_done(Globals.GameState.WATER_TAKEN) and not Globals.has_done(Globals.GameState.GARBAGE_THROWN):
				yield(
					E.run([
					'Lobo: Here we go! A MESS!!!!',
					'Pato: UUUUuuuUUUUuuuUUUuuu',
					A.play('sfx_spaceship_garbage', global_position)
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
