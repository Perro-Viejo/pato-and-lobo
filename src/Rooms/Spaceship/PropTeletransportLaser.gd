tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _ready() -> void:
	$AnimationPlayer.play('SETUP')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if C.player.last_room == 'HomesPlantation':
		E.run([
			'Lobo: Can not use the ray for that...'
		])
	elif C.player.last_room == 'Marrano':
		if Globals.has_done(Globals.GameState.WATER_TAKEN):
			yield(E.run([
				'Lobo: See the teletransport-ray in action!!!',
				_play(),
				A.play('sfx_spaceship_teleport', global_position),
				'Pato: Pffff... the pig was already comming.',
			]), 'completed')
			E.goto_room('Luna')

func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass


func _play() -> void:
	yield()
	$AnimationPlayer.play('turn_on')
	yield(get_tree(), 'idle_frame')
