tool
extends EditorPlugin

var import_plugin

func _enter_tree():
	if import_plugin == null:
		import_plugin = preload('load_json.gd').new()
		add_import_plugin(import_plugin)

func _exit_tree():
	if import_plugin != null:
		remove_import_plugin(import_plugin)
		import_plugin = null

func get_name():
	return "ASE to tres importer"
