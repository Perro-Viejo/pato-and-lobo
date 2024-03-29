extends CanvasLayer

onready var _info_bar: Label = find_node('InfoBar')
onready var _dialog_text: DialogText = find_node('DialogText')
onready var _display_box: DisplayBox = find_node('DisplayBox')
onready var _inventory_container: InventoryContainer = find_node('InventoryContainer')
onready var _click_handler: Button = $MainContainer/ClickHandler
onready var _dialog_menu: DialogMenu = find_node('DialogMenu')
onready var _toolbar: Toolbar = find_node('Toolbar')

# warning-ignore-all:return_value_discarded

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _ready():
	# --------------------------------------------------------------------------
	# Conectarse a eventos de los hijos
	# TODO: Algunos de estos realmente irán en el script de cada hijo
	_click_handler.connect('pressed', self, '_continue')
	_dialog_menu.connect('shown', self, '_disable_panels', [{ blocking = false }])
	_display_box.connect('shown', self, '_disable_panels')
	_display_box.connect('hidden', self, '_enable_panels')
	
	# Conectarse a eventos del universo digimon
	C.connect('character_spoke', self, '_show_dialog_text')
	G.connect('blocked', self, '_disable_panels')
	G.connect('freed', self, '_enable_panels')
	G.connect('interface_hidden', self, '_hide_panels')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
func _show_dialog_text(chr: Character, msg := '') -> void:
	_disable_panels()
	_dialog_text.play_text({
		text = msg,
		color = chr.text_color,
		position = Utils.get_screen_coords_for(chr.dialog_pos).floor(),
		offset_y = chr.get_dialog_pos()
	})


func _disable_panels(props := { blocking = true }) -> void:
	if props.blocking:
		_click_handler.mouse_filter = Control.MOUSE_FILTER_STOP
		G.waiting_click = true
#		_info_bar.text = '- clic para avanzar -'
	else:
		_click_handler.mouse_filter = Control.MOUSE_FILTER_IGNORE
		G.waiting_click = false
		_info_bar.hide()
	
	if _inventory_container.is_disabled: return

	_inventory_container.disable()
	_toolbar.disable()


func _enable_panels() -> void:
	# TODO: Usar Tween para que se oculte y aparezca con jugo
	_click_handler.mouse_filter = Control.MOUSE_FILTER_IGNORE
	G.waiting_click = false
	
	_display_box.dissapear()
	_dialog_text.hide()

#	_info_bar.text = ''
	_info_bar.show()

	if not E.current_room.hide_gi:
		_inventory_container.show()
		_inventory_container.enable()
	
	_toolbar.show()
	_toolbar.enable()


func _continue() -> void:
	if _dialog_text.percent_visible == 1.0:
		_dialog_text.hide()
		_display_box.dissapear()
		G.emit_signal('continue_clicked')
	else:
		_dialog_text.stop()


func _hide_panels() -> void:
	_inventory_container.hide()
	_info_bar.hide()
	_toolbar.hide()


func _show_panels() -> void:
	_inventory_container.show()
	_info_bar.show()
	_toolbar.show()
