extends Node

enum GameState {
	NONE,
	SEA_DREAMED,
	GOT_HOME,
	DOME_SPOTTED,
	GARBAGE_THROWN,
	WATER_TAKEN,
	WON_GAME
}

var game_progress := [GameState.NONE]
var asked_polas := 0
var courage := 0 setget _set_courage
var rooms_states := {}


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos públicos ░░░░
func has_done(id := -1) -> bool:
	return game_progress.has(id)


func did(id := -1) -> void:
	if not GameState.values().has(id): return
	if game_progress.has(id): return

	game_progress.append(id)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
func _set_courage(value: int) -> void:
	courage = value
	I.emit_signal('courage_updated', courage)
