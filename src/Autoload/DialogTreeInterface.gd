extends Node
# (D) Para hacer cosas con los árboles de diálogo

# warning-ignore-all:unused_signal
signal option_selected(opt)
signal dialog_requested
signal dialog_finished

export(Array, Resource) var trees := []

var active := false

var _current_tree: DialogTree = null


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos públicos ░░░░
func show_dialog(script_name: String) -> void:
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

			tree.start()
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
	emit_signal('dialog_finished')
