tool
class_name Character
extends Clickable
# Cualquier objeto que pueda hablar, caminar, moverse entre habitaciones, tener
# inventario, entre otras muchas cosas.

# TODO: Crear la máquina de estados

signal started_walk_to(character, start, end)

var last_room := ''

var _looking_dir := 'd'

export var text_color := Color.white
export var walk_speed := 200.0
export var is_player := false
export var texture: Texture setget _set_texture
export var vo_name := ''
export var follow_player := false

onready var sprite: Sprite = $Sprite


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _ready():
	# Conectarse a señales del cielo
	idle(false)
	set_process(follow_player)
	
	if Engine.editor_hint:
		set_process(true)


func _process(_delta: float) -> void:
	if Engine.editor_hint: ._process(_delta)
	elif is_instance_valid(C.player):
		global_position = C.player.global_position


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos públicos ░░░░
func walk(target_pos: Vector2, is_in_queue := true) -> void:
	if is_in_queue: yield()
	
	$Sprite.flip_h = target_pos.x < position.x
	_looking_dir = 'l' if $Sprite.flip_h else 'r'

	if E.cutscene_skipped:
		E.main_camera.smoothing_enabled = false
		yield(get_tree(), 'idle_frame')
		position = target_pos
		E.main_camera.position = target_pos
		yield(get_tree(), 'idle_frame')
		E.main_camera.smoothing_enabled = true
		return
	
	$AnimationPlayer.play('walk_%s' % _looking_dir)
	emit_signal('started_walk_to', self, position, target_pos)
	yield(C, 'character_move_ended')


func idle(is_in_queue := true) -> void:
	if is_in_queue: yield()
	$AnimationPlayer.play('idle_%s' % _looking_dir)
	yield(get_tree().create_timer(0.5), 'timeout')


func face_up(is_in_queue := true) -> void:
	if is_in_queue: yield()
	_looking_dir = 'u'
	yield(idle(false), 'completed')


func face_down(is_in_queue := true) -> void:
	if is_in_queue: yield()
	_looking_dir = 'd'
	yield(idle(false), 'completed')


func face_left(is_in_queue := true) -> void:
	if is_in_queue: yield()
	_looking_dir = 'l'
	$Sprite.flip_h = true
	yield(idle(false), 'completed')


func face_right(is_in_queue := true) -> void:
	if is_in_queue: yield()
	_looking_dir = 'r'
	$Sprite.flip_h = false
	yield(idle(false), 'completed')


func say(dialog: String, is_in_queue := true) -> void:
	if is_in_queue: yield()

	if E.cutscene_skipped:
		yield(get_tree(), 'idle_frame')
		return

	C.emit_signal('character_spoke', self, dialog)

	if vo_name:
		A.play(vo_name, global_position, false)
	$AnimationPlayer.play('talk_%s' % _looking_dir)

	yield(G, 'continue_clicked')
	idle(false)


func grab(is_in_queue := true) -> void:
	if is_in_queue: yield()
	
	if E.cutscene_skipped:
		yield(get_tree(), 'idle_frame')
		return
	
	$AnimationPlayer.play('grab_%s' % _looking_dir)
	
	if get_node_or_null('AnimatedSprite'):
		yield($AnimatedSprite, 'animation_finished')
	else:
		yield($AnimationPlayer, 'animation_finished')

	idle(false)


func get_dialog_pos() -> float:
	return sprite.position.y


# Quita un ítem del inventario del personaje (¿o del jugador?)
func remove_inventory() -> void:
	pass


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
func _set_texture(value: Texture) -> void:
	texture = value
	$Sprite.texture = value
