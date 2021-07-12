tool
extends Room

onready var _endings: VBoxContainer = find_node('Endings')
onready var _btn_restart: Button = find_node('BtnRestart')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _ready() -> void:
	$Props/Lovers.modulate.a = 0.0
	_btn_restart.modulate.a = 0.0
	
	for c in _endings.get_children():
		var rtl: RichTextLabel = c
		rtl.clear()
		rtl.append_bbcode('[center]%s[/center]' % tr('UNKNOWN'))
	
	_btn_restart.connect('pressed', self, '_restart_game')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_room_entered() -> void:
	$PanelContainer.modulate.a = 0.0


func on_room_transition_finished() -> void:
	if Globals.has_done(Globals.GameState.GOT_DRUNK):
		# Final loco: Lobo se come a Pato y nunca más lo vuelve a ver.
		Globals.achieved_endings.append(1)
		_replace_endings()
		yield(E.run([
			G.display('RoomEnd-GotDrunk-Game-01'),
			G.display('RoomEnd-GotDrunk-Game-02'),
			G.display('RoomEnd-GotDrunk-Game-03'),
			G.display('RoomEnd-GotDrunk-Game-04'),
			G.display('RoomEnd-GotDrunk-Game-05'),
			'...',
			G.display('RoomEnd-GotDrunk-Game-06'),
			G.display('RoomEnd-GotDrunk-Game-07'),
			G.display('RoomEnd-GotDrunk-Game-08'),
			G.display('RoomEnd-GotDrunk-Game-09'),
		]), 'completed')
	elif Globals.has_done(Globals.GameState.UNABLE):
		Globals.achieved_endings.append(2)
		_replace_endings()
		# Final triste: Pato es un fracaso, como nosotros.
		yield(E.run([
			G.display('RoomEnd-Unable-Game-01'),
			G.display('RoomEnd-Unable-Game-02'),
			E.wait(2),
			G.display('RoomEnd-Unable-Game-03'),
			G.display('RoomEnd-Unable-Game-04'),
		]), 'completed')
	elif Globals.has_done(Globals.GameState.ALL_DONE):
		Globals.achieved_endings.append(3)
		_replace_endings()
		# Final raro: Pato y Lobo se ríen de la estupidez del disfraz pero ella
		# le cuenta sus ensoñaciones y Lobo se enamora locamente.
		yield(E.run([
			G.display('RoomEnd-AllDone-Game-01'),
			G.display('RoomEnd-AllDone-Game-02'),
			G.display('RoomEnd-AllDone-Game-03'),
			G.display('RoomEnd-AllDone-Game-04'),
			G.display('RoomEnd-AllDone-Game-05'),
			G.display('RoomEnd-AllDone-Game-06'),
			G.display('RoomEnd-AllDone-Game-07'),
		]), 'completed')
		
		$Tween.interpolate_property(
			$Props/Lovers, 'modulate:a',
			0.0, 1.0,
			3.0, Tween.TRANS_SINE, Tween.EASE_OUT
		)
		$Tween.start()
		yield(get_tree().create_timer(6.0), 'timeout')
	else:
		# Final gracioso: Pato y Lobo se ríen de la estupidez del disfraz.
		Globals.achieved_endings.append(4)
		_replace_endings()
		yield(E.run([
			G.display('RoomEnd-Disguised-Game-01'),
			G.display('RoomEnd-Disguised-Game-02'),
			G.display('RoomEnd-Disguised-Game-03'),
			G.display('RoomEnd-Disguised-Game-04'),
			G.display('RoomEnd-Disguised-Game-05'),
			G.display('RoomEnd-Disguised-Game-06'),
		]), 'completed')
	
	_show_the_end()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
func _show_the_end() -> void:
	$Tween.interpolate_property(
		$PanelContainer, 'modulate:a',
		0.0, 1.0,
		3.0, Tween.TRANS_CIRC, Tween.EASE_OUT,
		1.0
	)
	$Tween.interpolate_property(
		_btn_restart, 'modulate:a',
		0.0, 1.0,
		0.7, Tween.TRANS_LINEAR, Tween.EASE_OUT,
		5.0
	)
	$Tween.start()


func _replace_endings() -> void:
	for idx in Globals.achieved_endings:
		_endings.get_child(idx - 1).clear()
		_endings.get_child(idx - 1).append_bbcode(
			'[center]%s[/center]' % tr('END_%d' % idx)
		)


func _restart_game() -> void:
	Globals.game_progress = [Globals.GameState.GAMEPLAY_EXPLAINED]
	Globals.courage = 0
	Globals.rooms_states = {}
	Globals.moon_song_played = false
	Globals.cosmo_kick_drunk = false
	C.player.anim_suffix = ''
	
	C.get_character('Lagarto').stop_music(false, false)
	I.emit_signal('courage_restarted')
	E.goto_room('Splash')
