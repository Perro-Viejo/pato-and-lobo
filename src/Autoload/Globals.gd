extends Node

enum GameState {
	NONE,
	SEA_DREAMED,
	GOT_HOME,
	ARM_DOWN,
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
	GOT_DRUNK,
	UNABLE,
	ALL_DONE,
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
		G.display('Globals-ExplainCharacterChange-Game-01'),
		G.display('Globals-ExplainCharacterChange-Game-02'),
		G.show_inventory()
	]), 'completed')


func moon_daydream_repeated() -> void:
	yield(E.run([
		G.display('Globals-MoonDaydreamRepeated-Game-01'),
		G.display('Globals-MoonDaydreamRepeated-Game-02'),
		'Pato: Globals-MoonDaydreamRepeated-Pato-03'
	]), 'completed')


func get_drunk() -> void:
	yield(E.run([
		'Conejuno: CocktailsMenu-Opt2-Conejuno-01',
		'Conejuno: CocktailsMenu-Opt2-Conejuno-02',
		'Pato: CocktailsMenu-Opt2-Pato-03',
		G.display('CocktailsMenu-Opt2-Game-04'),
		'Pato: CocktailsMenu-Opt2-Pato-05',
		G.display('CocktailsMenu-Opt2-Game-06'),
		A.play({cue_name = 'sfx_cocktail_use', pos = C.player.global_position}),
		'Pato: CocktailsMenu-Opt2-Pato-06',
		A.play({cue_name = 'sfx_drunk', pos = Vector2.ZERO}),
		E.wait(3),
		A.change_cue_pitch(C.get_character('Lagarto').current_track, -9),
		A.change_cue_pitch('bg_bar', -18),
		E.current_room.show_waving(),
		'Pato: CocktailsMenu-Opt2-Pato-07',
		G.display('CocktailsMenu-Opt2-Game-08'),
		C.player_walk_to(E.current_room.get_point('Drunk1')),
		'...',
		C.player_walk_to(E.current_room.get_point('Drunk2')),
		'...',
		C.player_walk_to(E.current_room.get_point('Drunk3')),
		'...',
		C.player_walk_to(E.current_room.get_point('Drunk4')),
		'...',
	]), 'completed')
	
	did(GameState.GOT_DRUNK)
	self.courage += 500
	yield(I, 'courage_update_shown')
	
	yield(E.run(['Pato: CocktailsMenu-Opt2-Pato-09',]), 'completed')
	C.get_character('Lobo').on_interact()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
func _set_courage(value: int) -> void:
	courage = value
	
	yield(E.wait(0.5, false), 'completed')
	I.emit_signal('courage_updated', courage)
