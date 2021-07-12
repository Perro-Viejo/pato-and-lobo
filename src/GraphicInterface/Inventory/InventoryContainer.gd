class_name InventoryContainer
extends Control
# warning-ignore-all:return_value_discarded

var is_disabled := false

var _can_hide_inventory := true

onready var _hide_y := rect_position.y - (rect_size.y - 26)
onready var _foreground: TextureRect = find_node('InventoryForeground')
onready var _grid: GridContainer = find_node('InventoryGrid')
onready var _courage: TextureProgress = find_node('Courage')
onready var _courage_label: Label = find_node('CourageLabel') as Label
onready var _courage_code: String = _courage_label.text


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _ready():
	rect_position.y = _hide_y
	rect_size.x = _foreground.rect_size.x
	_courage.value = Globals.courage
	
	# TODO: Hacer algo así para los casos en los que se quiera que el inventario
	# inicie ya con unos objetos dentro.

	# Conectarse a señales del yo
	connect('mouse_entered', self, '_open')
	connect('mouse_exited', self, '_close')
	
	# Conectarse a las señales del papá de los inventarios
	I.connect('item_added', self, '_add_item')
	I.connect('item_removed', self, '_remove_item')
	I.connect('courage_updated', self, '_show_courage')
	I.connect('courage_restarted', self, '_restart_courage')
	G.connect('inventory_show_requested', self, '_show_and_hide')
	E.connect('language_changed', self, '_translate')
	
	_translate()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos públicos ░░░░
func disable() -> void:
	is_disabled = true
	$Tween.interpolate_property(
		self, 'rect_position:y',
		_hide_y, _hide_y - 26,
		0.3, Tween.TRANS_LINEAR, Tween.EASE_OUT
	)
	$Tween.start()


func enable() -> void:
	is_disabled = false
	$Tween.interpolate_property(
		self, 'rect_position:y',
		_hide_y - 3.5, _hide_y,
		0.3, Tween.TRANS_SINE, Tween.EASE_OUT
	)
	$Tween.start()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
func _open() -> void:
	if not is_disabled and rect_position.y != _hide_y: return

	$Tween.interpolate_property(
		self, 'rect_position:y',
		_hide_y if not is_disabled else rect_position.y, 0.0,
		0.5, Tween.TRANS_EXPO, Tween.EASE_OUT
	)
	$Tween.start()


func _close() -> void:
	yield(get_tree(), 'idle_frame')

	if not _can_hide_inventory: return

	$Tween.interpolate_property(
		self, 'rect_position:y',
		0.0, _hide_y if not is_disabled else _hide_y - 3.5,
		0.3, Tween.TRANS_SINE, Tween.EASE_IN
	)
	$Tween.start()


func _show_item_info(description := '') -> void:
	_can_hide_inventory = false if description else true


func _change_cursor(item: Item) -> void:
	I.set_active_item(item)


func _add_item(item: Item) -> void:
	_grid.add_child(item)
	
	item.connect('description_toggled', self, '_show_item_info')
	item.connect('selected', self, '_change_cursor')
	
	if not G.blocked:
		_open()
		yield($Tween, 'tween_all_completed')
		yield(get_tree().create_timer(2.0), 'timeout')
		_can_hide_inventory = true
		_close()
		yield($Tween, 'tween_all_completed')

	I.emit_signal('item_add_done', item)


func _remove_item(item: Item) -> void:
	if not _grid.get_node_or_null(item.name): return
	
	item.disconnect('description_toggled', self, '_show_item_info')
	item.disconnect('selected', self, '_change_cursor')
	_grid.remove_child(item)
	
	_can_hide_inventory = true
	
	yield(get_tree(), 'idle_frame')
	
	I.emit_signal('item_remove_done', item)


func _show_courage(courage: int) -> void:
	if courage == 0: return
	_open()
	yield($Tween, 'tween_all_completed')
	$Tween.interpolate_property(
		_courage, 'value',
		_courage.value, courage,
		1.0, Tween.TRANS_SINE, Tween.EASE_OUT
	)
	$Tween.start()
	if Globals.has_done(Globals.GameState.GOT_DRUNK):
		A.play({cue_name = 'sfx_ui_courage_drunk', pos = Vector2.ZERO, is_in_queue = false})
	else:
		A.play({cue_name = 'sfx_ui_courage_fill', pos =Vector2.ZERO, is_in_queue = false})
	yield($Tween, 'tween_all_completed')
	_close()
	yield($Tween, 'tween_all_completed')
	I.emit_signal('courage_update_shown')


func _show_and_hide(time := 1.0) -> void:
	_open()
	yield($Tween, 'tween_all_completed')
	yield(E.wait(time, false), 'completed')
	_close()
	yield($Tween, 'tween_all_completed')
	G.emit_signal('inventory_shown')


func _translate() -> void:
	_courage_label.text = E.get_text(_courage_code)


func _restart_courage() -> void:
	_courage.value = 0
