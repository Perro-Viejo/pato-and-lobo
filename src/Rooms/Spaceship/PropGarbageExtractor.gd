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
			'Lobo: RoomSpaceship-GarbageExtractor-Lobo-01',
			'Lobo: RoomSpaceship-GarbageExtractor-Lobo-02'
			
		])
#	elif C.player.last_room == 'Marrano':
	else:
		if Globals.has_done(Globals.GameState.DOME_SPOTTED):
			if not Globals.has_done(Globals.GameState.GARBAGE_THROWN):
				yield(
					E.run([
					'Lobo: RoomSpaceship-GarbageExtractor-Lobo-03',
					A.play({cue_name = 'sfx_spaceship_garbage', pos = global_position}),
					play('open'),
					'Pato: RoomSpaceship-GarbageExtractor-Pato-01',
				]), 'completed')
				Globals.did(Globals.GameState.GARBAGE_THROWN)
				E.goto_room('Marrano')
			elif not Globals.has_done(Globals.GameState.WATER_TAKEN): 
				E.run([
					'Lobo: RoomSpaceship-GarbageExtractor-Lobo-04',
					'Lobo: RoomSpaceship-GarbageExtractor-Lobo-05'
				])
			else:
				E.run([
					'Lobo: RoomSpaceship-GarbageExtractor-Lobo-06'
				])
		else:
			E.run([
				'Lobo: RoomSpaceship-GarbageExtractor-Lobo-07'
			])

func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass


func play(anim_name: String, is_in_queue := true) -> void:
	if is_in_queue: yield()
	
	$AnimationPlayer.play(anim_name)
	yield($AnimationPlayer, 'animation_finished')

