tool
extends Node

export(Array, Resource) var cues = [] setget _set_cues

var twelfth_root_of_two := pow(2, (1.0 / 12))

var _vo_cues := {}


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _ready() -> void:
	for c in cues:
		var cue: AudioCue = c
		if cue.resource_name.to_lower().find('vo_') > -1:
			_vo_cues[cue.resource_name.to_lower()] = cue


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos públicos ░░░░
func semitone_to_pitch(pitch: float) -> float:
	return pow(twelfth_root_of_two, pitch)


func play_sfx() -> void:
	pass


func play_music() -> void:
	pass


func play_vo(vo_name: String, pos := Vector2.ZERO, is_in_queue := true) -> void:
	if _vo_cues.has(vo_name.to_lower()):
		if is_in_queue: yield()

		var cue: AudioCue = _vo_cues[vo_name.to_lower()]
		if cue.is_2d:
			var stream_player_2d: AudioStreamPlayer2D = $Positional2D.get_child(0)
			stream_player_2d.stream = cue.audio
			stream_player_2d.pitch_scale = cue.get_pitch()
			stream_player_2d.volume_db = cue.volume
			stream_player_2d.position = pos
			
			stream_player_2d.play()
	else:
		printerr('AudioManager.play_vo: No se encontró el VO', vo_name)
	yield(get_tree(), 'idle_frame')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
func _set_cues(value: Array) -> void:
	cues = value
	for idx in value.size():
		if not value[idx]:
			var new_opt: AudioCue = AudioCue.new()
			cues[idx] = new_opt
			property_list_changed_notify()

