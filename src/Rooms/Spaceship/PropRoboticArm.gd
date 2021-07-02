tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _ready() -> void:
	$AnimationPlayer.play('SETUP')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if C.player.last_room == 'HomesPlantation':
		if Globals.has_done(Globals.GameState.GOT_HOME):
			yield(
				E.run([
				'Lobo: RoomSpaceship-RoboticArm-Lobo-01',
				'Pato: RoomSpaceship-RoboticArm-Pato-01',
				_play(),
				A.play({cue_name = 'sfx_spaceship_hook', pos = global_position}),
				E.wait(1.3)
			]), 'completed')
			Globals.did(Globals.GameState.ARM_DOWN)
			E.goto_room('HomesPlantation', false)
		else:
			E.run([
			'Lobo: RoomSpaceship-RoboticArm-Lobo-02'
			])
	elif C.player.last_room == 'Marrano':
		if Globals.has_done(Globals.GameState.WATER_TAKEN):
			E.run([
				'Lobo: RoomSpaceship-RoboticArm-Lobo-03'
			])
	else:
		E.run([
			'Lobo: RoomSpaceship-RoboticArm-Lobo-04'
		])


func on_look() -> void:
	E.run(['Lobo: RoomSpaceship-RoboticArm-Lobo-05'])


func on_item_used(_item: Item) -> void:
	pass


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
func _play() -> void:
	yield()
	$AnimationPlayer.play('pull')
	yield(get_tree(), 'idle_frame')
