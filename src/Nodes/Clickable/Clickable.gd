tool
class_name Clickable
extends Area2D
# Permite definir colisiones que reaccionan a los eventos de clic y entrada y
# salida del cursor.

# TODO: Hacer la lógica para el uso de objetos de inventario sobre este nodo

export var description := ''
export var clickable := true
export var baseline := 0 setget _set_baseline
export var walk_to_point: Vector2 setget _set_walk_to_point
export var look_at_point: Vector2
export(Cursor.Type) var cursor
export var script_name := ''


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
# warning-ignore-all:return_value_discarded
func _ready():
	connect('visibility_changed', self, '_toggle_input')

	if clickable:
		connect('mouse_entered', self, '_toggle_description', [true])
		connect('mouse_exited', self, '_toggle_description', [false])
	
	if not Engine.editor_hint:
		remove_child($BaselineHelper)
		remove_child($WalkToHelper)
	
	set_process_unhandled_input(false)


func _unhandled_input(event):
	var mouse_event: = event as InputEventMouseButton 
	if mouse_event and mouse_event.pressed:
		if event.is_action_pressed('interact'):
			# TODO: Verificar si hay un elemento de inventario seleccionado
			get_tree().set_input_as_handled()
			E.clicked = self
			if I.active:
				on_item_used(I.active)
			else:
				on_interact()
		elif event.is_action_pressed('look'):
			if not I.active:
				on_look()


func _process(_delta):
	if Engine.editor_hint:
		if walk_to_point != get_node('WalkToHelper').position:
			# Esto debería ocurrir sólo si se cambiar en el editor la posición
			# del WalkToHelper
			walk_to_point = get_node('WalkToHelper').position
			property_list_changed_notify()
		elif baseline != get_node('BaselineHelper').position.y:
			baseline = get_node('BaselineHelper').position.y
			property_list_changed_notify()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	yield(G.display('No hay na\' pa\' hacer con esta mondá', false), 'completed')
	G.done()


func on_look() -> void:
	yield(G.display('No es nada...', false), 'completed')
	G.done()


func on_item_used(_item: Item) -> void:
	pass


# Oculta el objeto y hace que no reciba interacciones
func disable(is_in_queue := true) -> void:
	if is_in_queue: yield()
	self.visible = false
	yield(get_tree(), 'idle_frame')


func enable(is_in_queue := true) -> void:
	if is_in_queue: yield()
	self.visible = true
	yield(get_tree(), 'idle_frame')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
func _toggle_description(display: bool) -> void:
	set_process_unhandled_input(display)
	Cursor.set_cursor(cursor if display else null)
	if display:
		if not I.active:
			G.show_info(description)
		else:
			G.show_info('Usar %s en %s' % [I.active.description, description])
	else:
		G.show_info()


func _set_baseline(value: int) -> void:
	baseline = value
	
	if Engine.editor_hint and get_node_or_null('BaselineHelper'):
		get_node('BaselineHelper').position = Vector2.DOWN * value


func _set_walk_to_point(value: Vector2) -> void:
	walk_to_point = value
	
	if Engine.editor_hint and get_node_or_null('WalkToHelper'):
		get_node('WalkToHelper').position = value


func _toggle_input() -> void:
	if clickable:
		input_pickable = visible
		set_process_unhandled_input(false)
