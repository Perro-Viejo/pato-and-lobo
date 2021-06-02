extends Node

enum GameState {
	NONE,
	SEA_DREAMED,
	GOT_HOME,
	DOME_SPOTTED,
	GARBAGE_THROWN,
	DOME_DESTROYED,
	WATER_TAKEN,
	WON_GAME,
	MASK_TAKEN,
	DENTURES_TAKEN,
	LEGS_TAKEN,
	TAIL_TAKEN,
	DISGUISED,
	CHARACTER_CHANGE_EXPLAINED,
}

var game_progress := [GameState.NONE]
var asked_polas := 0
var courage := 0 setget _set_courage
var rooms_states := {}
var moon_song_played := false
var cosmo_kick_drunk := false


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos públicos ░░░░
func has_done(id := -1) -> bool:
	return game_progress.has(id)


func did(id := -1) -> void:
	if not GameState.values().has(id): return
	if game_progress.has(id): return

	game_progress.append(id)


func explain_character_change() -> void:
	did(GameState.CHARACTER_CHANGE_EXPLAINED)
	
	yield(E.run([
		G.display('Globals-CharacterChange-Game-01'),
		G.display('Globals-CharacterChange-Game-02'),
		G.show_inventory()
	]), 'completed')


func moon_daydream_repeated() -> void:
	yield(E.run([
		G.display('Globals-MoonDaydreamRepeated-Game-01'),
		G.display('Globals-MoonDaydreamRepeated-Game-02'),
		'Pato: Globals-MoonDaydreamRepeated-Pato-03'
	]), 'completed')



# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
func _set_courage(value: int) -> void:
	courage = value
	
	yield(E.wait(0.5, false), 'completed')
	I.emit_signal('courage_updated', courage)
