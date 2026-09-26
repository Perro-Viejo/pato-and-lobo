extends Node
# (D) Para hacer cosas con los árboles de diálogo

# warning-ignore-all:unused_signal
signal option_selected(opt)
signal dialog_requested
signal dialog_finished

export(Array, Resource) var trees := []

var active := false

var _current_tree: DialogTree = null
var _dflt_trees := []


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _ready() -> void:
	for t in trees:
		var tree := DialogTree.new()
		tree.set_script(t.get_script())
		tree.script_name = t.script_name
		tree.options = []
		for o in t.options:
			var dialog_option := DialogOption.new()
			dialog_option.id = o.id
			dialog_option.text = o.text
			dialog_option.visible = o.visible
			dialog_option.description = o.description
			dialog_option.disabled = o.disabled
			dialog_option.used = o.used
			dialog_option.script_name = o.script_name
			
			tree.options.append(dialog_option)
		
		_dflt_trees.append(tree)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos públicos ░░░░
func show_dialog(script_name: String, show_start := true) -> void:
	if _current_tree:
		# Si hay un diálogo en progreso y se solicitó otro, hay que desconectar
		# al diálogo en progreso para que el nuevo diálogo escuche la selección
		# de las opciones
		_current_tree.disconnect_option_selection()
	
	for t in trees:
		var tree: DialogTree = t
		if tree.script_name.to_lower() == script_name.to_lower():
			active = true
			_current_tree = tree
			
			if show_start:
				tree.start()
			else:
				tree.show_options()
			yield(self, 'dialog_finished')

			if active:
				# Para que esto pase sólo una vez si quedaron DialogTree a la
				# espera de la señal dialog_finished.
				active = false
				_current_tree = null
				G.done()

	# Por si no se encuentra el diálogo
	yield(get_tree(), 'idle_frame')


func finish_dialog() -> void:
	E.main_camera.offset_v = 0.0
	emit_signal('dialog_finished')


func get_dialog_tree(script_name: String) -> DialogTree:
	for t in trees:
		var tree: DialogTree = t
		if tree.script_name.to_lower() == script_name.to_lower():
			return t
	return null


func reset_dialogs() -> void:
	_current_tree = null
	active = false
	trees.clear()
	for t in _dflt_trees:
		var tree := DialogTree.new()
		tree.set_script(t.get_script())
		tree.script_name = t.script_name
		tree.options = []
		for o in t.options:
			var dialog_option := DialogOption.new()
			dialog_option.id = o.id
			dialog_option.text = o.text
			dialog_option.visible = o.visible
			dialog_option.description = o.description
			dialog_option.disabled = o.disabled
			dialog_option.used = o.used
			dialog_option.script_name = o.script_name
			
			tree.options.append(dialog_option)
		trees.append(tree)
