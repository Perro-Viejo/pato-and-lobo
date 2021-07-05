class_name Toolbar
extends NinePatchRect

export(Cursor.Type) var cursor
export var script_name := ''
export var used_in_game := true

var is_disabled := false

var _can_hide := true

onready var _grid: GridContainer = find_node('Grid')
onready var _hide_y := rect_position.y - (rect_size.y - 26)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
# warning-ignore-all:return_value_discarded
func _ready() -> void:
	rect_position.y = _hide_y
	
	if OS.has_feature('HTML5') or OS.has_feature('web'):
		rect_size.x = 313.0
		margin_right = -16.0
		margin_left = 0.0
	
	# Conectarse a señales del yo
	connect('mouse_entered', self, '_open')
	connect('mouse_exited', self, '_close')
	
	# Conectarse a señales de los hijos de la mamá
	for b in _grid.get_children():
		(b as TextureButton).connect('mouse_entered', self, '_disable_hide')
		(b as TextureButton).connect('mouse_exited', self, '_enable_hide')

	if not used_in_game:
		hide()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos públicos ░░░░
func disable() -> void:
	if not used_in_game: return
	
	is_disabled = true
	$Tween.interpolate_property(
		self, 'rect_position:y',
		_hide_y, _hide_y - 3.5,
		0.3, Tween.TRANS_LINEAR, Tween.EASE_OUT
	)
	$Tween.start()


func enable() -> void:
	if not used_in_game: return
	
	is_disabled = false
	$Tween.interpolate_property(
		self, 'rect_position:y',
		_hide_y - 3.5, _hide_y,
		0.3, Tween.TRANS_SINE, Tween.EASE_OUT
	)
	$Tween.start()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
func _open() -> void:
	if not used_in_game: return
	
	if not is_disabled and rect_position.y != _hide_y: return
	$Tween.interpolate_property(
		self, 'rect_position:y',
		_hide_y if not is_disabled else rect_position.y, 0.0,
		0.5, Tween.TRANS_EXPO, Tween.EASE_OUT
	)
	$Tween.start()


func _close() -> void:
	if not used_in_game: return
	
	yield(get_tree(), 'idle_frame')
	if not _can_hide: return
	$Tween.interpolate_property(
		self, 'rect_position:y',
		0.0, _hide_y if not is_disabled else _hide_y - 3.5,
		0.2, Tween.TRANS_SINE, Tween.EASE_IN
	)
	$Tween.start()


func _disable_hide() -> void:
	_can_hide = false


func _enable_hide() -> void:
	_can_hide = true
