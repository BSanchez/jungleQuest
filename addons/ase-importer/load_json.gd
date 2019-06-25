tool
extends EditorImportPlugin

func get_importer_name():
		return "demos.ase"

func get_visible_name():
		return "Aseprite Spritesheet"

func get_recognized_extensions():
		return ["json"]

func get_save_extension():
		return "aseprite-spritesheet"

func get_resource_type():
		return "SpriteFrames"
