tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _ready() -> void:
	$AnimationPlayer.play('SETUP')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if C.player.last_room == 'HomesPlantation':
		E.run([
			'Lobo: RoomSpaceship-TeletransportRay-Lobo-01'
		])
	elif C.player.last_room == 'Marrano':
		if Globals.has_done(Globals.GameState.WATER_TAKEN):
			yield(E.run([
				'Lobo: RoomSpaceship-TeletransportRay-Lobo-02',
				_play(),
				A.play({cue_name = 'sfx_spaceship_teleport', pos = global_position}),
				'Pato: RoomSpaceship-TeletransportRay-Pato-01',
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
