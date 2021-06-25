tool
extends Character

var music_playing = false
var current_track = ''

var _using_mask := true

onready var timer = $Timer

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _ready() -> void:
	timer.connect('timeout', self, 'play_music', ['mx_bar_gen', false])
	print('Y suenaaa: ', current_track)
	_looking_dir = 'mask'
	idle(false)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked(),
		'Pato: Character-Lagarto-OnInteract-Pato-01',
	]), 'completed')
	
	if _using_mask:
		yield(E.run(['Lagarto: Character-Lagarto-OnInteract-Lagarto-02']), 'completed')
	elif _can_put_mask():
		yield(
			E.run([
				'Lagarto: Character-Lagarto-OnInteract-Lagarto-03',
				put_mask(),
				'Lagarto: Character-Lagarto-OnInteract-Lagarto-04'
			]),
			'completed'
		)
	else:
		yield(
			E.run([
				'Lagarto: Character-Lagarto-OnInteract-Lagarto-05',
				'Lagarto: Character-Lagarto-OnInteract-Lagarto-06',
				C.player.face_right(),
				'Pato: Character-Lagarto-OnInteract-Pato-07'
			]),
			'completed'
		)
	D.show_dialog('ChatWithLagarto')


func on_look() -> void:
	if _using_mask:
		E.run(['Pato: Character-Lagarto-OnLook-Pato-01'])
	elif _can_put_mask():
		E.run(['Pato: Character-Lagarto-OnLook-Pato-02'])
	else:
		E.run(['Pato: Character-Lagarto-OnLook-Pato-03'])

#Funciones de DJ
func play_music(track = 'mx_bar_gen', is_in_queue := true):
	if is_in_queue: yield()
	if music_playing:
		stop_music(false)
		A.play_music(track, false)
		music_playing = true
	else:
		A.play_music(track, false)
		music_playing = true
	if is_inside_tree(): yield(get_tree(), 'idle_frame')

func stop_music(is_in_queue := true):
	if is_in_queue: yield()
	A.stop(current_track, 0, false)
	music_playing = false
	current_track = ''

func check_music():
	if not music_playing:
		$Timer.wait_time = rand_range(3, 8)
		$Timer.start()

func remove_mask(is_in_queue := true) -> void:
	if is_in_queue: yield()
	yield(_toggle_mask(false), 'completed')


func put_mask(is_in_queue := true) -> void:
	if is_in_queue: yield()
	yield(_toggle_mask(), 'completed')


func _toggle_mask(put := true) -> void:
	if not _can_put_mask():
		yield(get_tree(), 'idle_frame')
		return
	
	_using_mask = put
	_looking_dir = 'mask' if put else 'd'
	E.current_room.state.dj_uses_mask = put

	if put:
		E.current_room.get_prop('WolfMask').disable(false)
	else:
		E.current_room.get_prop('WolfMask').enable(false)

	idle(false)
	yield(get_tree().create_timer(0.3), 'timeout')


func _can_put_mask():
	return E.current_room.state.has_mask

