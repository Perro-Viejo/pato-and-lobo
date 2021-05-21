class_name DisplayBox
extends Label

signal shown
signal hidden

export var wrap_width := 192.0
export var narrator_name := ''

onready var _min_width := rect_min_size.x
onready var _dflt_height := rect_min_size.y


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _ready() -> void:
	text = ''
	
	G.connect('show_box_requested', self, '_show_box')
	
	hide()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
func _show_box(msg := '') -> void:
	text = ''
	rect_size = Vector2(_min_width, _dflt_height)
	rect_min_size = Vector2(_min_width, _dflt_height)
	autowrap = false
	if narrator_name:
		text = narrator_name + ': ' + msg
	else:
		text = msg

	if msg:
		show()
		emit_signal('shown')
	else:
		hide()
		emit_signal('hidden')

	# Ajustar el tamaño del Label si excede el tamaño máximo definido para que el
	# texto se auto-ajuste.
	if rect_size.x > wrap_width:
		autowrap = true
		rect_size.x = wrap_width
	rect_size.y = (get_line_count() - 1) * _dflt_height
	
	# Centrar el Label en la ventana
	rect_position = Vector2(E.half_width - rect_size.x / 2.0, E.half_height - rect_size.y / 2.0)
