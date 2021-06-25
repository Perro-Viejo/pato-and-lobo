tool
extends Node

export(Array, Resource) var cues = [] setget _set_cues

var twelfth_root_of_two := pow(2, (1.0 / 12))

var _vo_cues := {}
var _sfx_cues := {}
var _mx_cues := {}
var _active := {}


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
# warning-ignore-all:return_value_discarded
func _ready() -> void:
	for c in cues:
		var cue: AudioCue = c
		var cue_name := cue.resource_name.to_lower()
		
		if cue_name.find('vo_') > -1:
			_vo_cues[cue_name] = cue
		elif cue_name.find('mx_') > -1:
			_mx_cues[cue_name] = cue
		else:
			_sfx_cues[cue_name] = cue


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos públicos ░░░░
func semitone_to_pitch(pitch: float) -> float:
	return pow(twelfth_root_of_two, pitch)


func play(cue_name: String, pos := Vector2.ZERO, is_in_queue := true, wait_audio_complete := false) -> void:
	if is_in_queue: yield()

	var dic: Dictionary = {}
	var stream_player: Node = null
	
	if cue_name.find('vo_') > -1: dic = _vo_cues
	else: dic = _sfx_cues
	
	if dic.has(cue_name.to_lower()):
		var cue: AudioCue = dic[cue_name.to_lower()]
		stream_player = _play(cue, pos)
	else:
		printerr('AudioManager.play: No se encontró el sonido', cue_name)
	
	if stream_player and wait_audio_complete:
		yield(stream_player, 'finished')
	else:
		yield(get_tree(), 'idle_frame')


func play_music(cue_name: String, is_in_queue := true) -> void:
	# TODO: Puede que sí necesite recibir la posición por si se quiere que la música
	# salga de un lugar específico (p.e. una radio en el escenario).
	if _mx_cues.has(cue_name.to_lower()):
		if is_in_queue: yield()

		var cue: AudioCue = _mx_cues[cue_name.to_lower()]
		_play(cue)
		C.get_character('Lagarto').current_track = cue_name
	else:
		printerr('AudioManager.play_music: No se encontró la música', cue_name)
	yield(get_tree(), 'idle_frame')


func stop(cue_name: String, _instance_i := 0, is_in_queue := true) -> void:
	if is_in_queue: yield()

	if _active.has(cue_name):
		var stream_player: Node = (_active[cue_name].players as Array).pop_front()
		
		if is_instance_valid(stream_player):
			stream_player.stop()
			
			if stream_player is AudioStreamPlayer2D and _active[cue_name].loop:
				# Cuando se detiene (.stop()) un audio en loop, por alguna razón
				# no se llama la señal de 'finished'.
				stream_player.emit_signal('finished')
		else:
			_active.erase(cue_name)

	yield(get_tree(), 'idle_frame')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
func _set_cues(value: Array) -> void:
	cues = value
	for idx in value.size():
		if not value[idx]:
			var new_opt: AudioCue = AudioCue.new()
			cues[idx] = new_opt
			property_list_changed_notify()


# Reproduce el sonido y se encarga de la lógica que lo asigna a un AudioStreamPlayer
# o crea uno nuevo si no hay disponibles
func _play(cue: AudioCue, pos := Vector2.ZERO) -> Node:
	var player: Node = null
	
	if cue.is_2d:
		player = _get_free_stream($Positional)
		
		if not is_instance_valid(player):
			prints('AudioManager._play(...): Nos quedamos sin AudioStreamPlayer2D')
			return null

		(player as AudioStreamPlayer2D).stream = cue.audio
		(player as AudioStreamPlayer2D).pitch_scale = cue.get_pitch()
		(player as AudioStreamPlayer2D).volume_db = cue.volume
		(player as AudioStreamPlayer2D).max_distance = cue.max_distance
		(player as AudioStreamPlayer2D).position = pos
	else:
		player = _get_free_stream($Generic)
		
		if not is_instance_valid(player):
			prints('AudioManager._play(...): Nos quedamos sin AudioStreamPlayer')
			return null

		(player as AudioStreamPlayer).stream = cue.audio
		(player as AudioStreamPlayer).pitch_scale = cue.get_pitch()
		(player as AudioStreamPlayer).volume_db = cue.volume

	var cue_name := cue.resource_name
	var debug_idx: int = DebugOverlay.add_monitor('\n' + cue_name, player, ':playing')
	
	player.bus = cue.bus
	player.play()
	player.connect('finished', self, '_make_available', [player, cue_name, debug_idx])
	
	if _active.has(cue_name):
		_active[cue_name].players.append(player)
	else:
		_active[cue_name] = {
			players = [player],
			loop = cue.loop
		}

	return player


func _get_free_stream(group: Node):
	var active_stream: Node = _reparent(group, $Active, 0)
	# TODO: Que cree un AudioStreamPlayer cuando no hay hijos

	return active_stream


# Reasigna el AudioStreamPlayer a su grupo original cuando ha terminado de sonar
# pa' que vuelva a estar disponible para ser usado
func _make_available(stream_player: Node, cue_name: String, debug_idx: int) -> void:
	if 'mx' in cue_name:
		if not cue_name == 'mx_bar_gen':
			C.get_character('Lagarto').music_playing = false
			C.get_character('Lagarto').check_music()
	if stream_player is AudioStreamPlayer:
		_reparent($Active, $Generic, stream_player.get_index())
	else:
		_reparent($Active, $Positional, stream_player.get_index())

	var players: Array = _active[cue_name].players
	for idx in players.size():
		if players[idx].get_instance_id() == stream_player.get_instance_id():
			players.remove(idx)
			break
	
	if players.empty():
		_active.erase(cue_name)

	stream_player.disconnect('finished', self, '_make_available')
	
	DebugOverlay.remove_monitor(debug_idx)


func _reparent(source: Node, target: Node, child_idx: int) -> Node:
	if source.get_children().empty(): return null
	
	var node_to_reparent: Node = source.get_child(child_idx)

	source.remove_child(node_to_reparent)
	target.add_child(node_to_reparent)

	return node_to_reparent
