extends Node
# (C) Para hacer cosas con los personajes

# warning-ignore-all:unused_signal
# El nodo Character que se movió en la escena
signal character_moved(character)
signal character_spoke(character, message)
signal character_move_ended(character)
signal character_say(chr_name, dialog)

var player: Character = null setget _set_player
var characters := []
var camera_owner: Character = null


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos públicos ░░░░
func character_say(
	chr_name: String, dialog: String, is_in_queue := true
	) -> void:
	if is_in_queue: yield()

	var talking_character: Character = get_character(chr_name)
	if talking_character:
		yield(talking_character.say(dialog, false), 'completed')
	else:
		printerr('CharacterInterface.character_say:', 'character %s not found')


func player_say(dialog: String, is_in_queue := true) -> void:
	if is_in_queue: yield()
	
	yield(player.say(dialog, false), 'completed')


func character_walk_to(
	chr_name: String, position: Vector2, is_in_queue := true
	) -> void:
	if is_in_queue: yield()
	
	var walking_character: Character = get_character(chr_name)
	if walking_character:
		yield(walking_character.walk(position, false), 'completed')
	else:
		printerr('CharacterInterface.character_walk_to:', 'character %s not found')


func player_walk_to(position: Vector2, is_in_queue := true) -> void:
	if is_in_queue: yield()
	yield(C.player.walk(position, false), 'completed')


func walk_to_clicked(is_in_queue := true) -> void:
	if is_in_queue: yield()
	yield(
		player_walk_to(E.clicked.walk_to_point + E.clicked.position, false),
		'completed'
	)


func is_valid_character(chr_name: String) -> bool:
	for c in characters:
		if (c as Character).script_name.to_lower() == chr_name.to_lower():
			return true
	return false


func get_character(script_name: String) -> Character:
	for c in characters:
		if (c as Character).script_name.to_lower() == script_name.to_lower():
			return c
	return null


func change_camera_owner(c: Character, is_in_queue := true) -> void:
	if is_in_queue: yield()
	
	if E.cutscene_skipped:
		camera_owner = c
		yield(get_tree(), 'idle_frame')
		return
	
	camera_owner = c
	yield(get_tree(), 'idle_frame')


func face_clicked(is_in_queue := true) -> void:
	if is_in_queue: yield()
	
	if E.clicked.global_position < C.player.global_position:
		yield(C.player.face_left(false), 'completed')
	else:
		yield(C.player.face_right(false), 'completed')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
func _set_player(value: Character) -> void:
	player = value
	camera_owner = value
