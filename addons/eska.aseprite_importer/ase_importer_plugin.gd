# Copyright (c) eska <eska@eska.me>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

## \TODO toggle for track stretching
## \TODO toggle for aggressive?

tool
extends EditorImportPlugin

var Sheet = preload('sheet.gd')
# var SheetToScene = preload('sheet2scene.gd')

const ERRMSG_POSTCODE_STRF =\
""" (Code %d)"""
const ERRMSG_SHEET_PRETEXT_STRF =\
"""Sprite sheet file %s has invalid data:\n"""
const ERRMSG_FILE_OPEN_STRF =\
"""Failed to open %s file %s for import"""
const ERRMSG_FILE_INVALID_STRF =\
"""File %s is not a valid %s file"""
const ERRMSG_SAVE_STRF =\
"""Failed to save file %s"""
const ERRMSG_MERGE_PRETEXT_STRF =\
"""Merging sprite sheet scene %s failed\n"""
const WARNMSG_ANIMATION_EXPORT_STRF=\
"""File %s was exported without animations.
Enable Meta: Frame Tags in Aseprite's Export Sprite Sheet dialog to export frame tags as animations"""


const PLUGIN_NAME = "bsanchez.aseprite_importer"

func get_importer_name():
	return PLUGIN_NAME

func get_visible_name():
	return "Aseprite Spritesheet"

func get_recognized_extensions():
	return ["json"]

func get_save_extension():
	return "tres"

func get_resource_type():
	return "SpriteFrames"

func get_option_visibility(option, options):
	return true

func get_preset_count():
	return 1

func get_preset_name(preset):
	return "Default"

func get_import_options(preset):
	var options =  [
		{
			name = "sheet_image",
			default_value = "",
			property_hint = PROPERTY_HINT_FILE,
			hint_string = "*.png",
			#tooltip = "Absolute path to the spritesheet .png, if its path differs from the .json after stripping extensions.",
		}
	]

	return options

func import(src, target_path, import_options, r_platform_variants, r_gen_files):
	var json_path = src
	var texture_path = import_options.sheet_image
	target_path = target_path + "." + get_save_extension()

	var file = File.new()
	var error
	error = file.open( json_path, File.READ )
	if error != OK:
		file.close()
		print( str( ERRMSG_FILE_OPEN_STRF % ["JSON", json_path], ERRMSG_POSTCODE_STRF % error ))
		return error

	var sheet = Sheet.new()
	error = sheet.parse_json( file.get_as_text() )
	file.close()
	if error != OK:
		print(str( ERRMSG_SHEET_PRETEXT_STRF % json_path, sheet.get_error_message(), ERRMSG_POSTCODE_STRF % error ))
		return error
	if not sheet.is_animations_enabled():
		print( WARNMSG_ANIMATION_EXPORT_STRF % json_path )

	if texture_path == "":
		texture_path = json_path.get_basename() + ".png"

	if not file.file_exists( texture_path ):
		print( ERRMSG_FILE_OPEN_STRF % ["texture", texture_path] )
		return ERR_FILE_NOT_FOUND
	var texture = load( texture_path )
	if not typeof(texture) == TYPE_OBJECT or not texture is Texture:
		print( ERRMSG_FILE_INVALID_STRF % [texture_path, "texture"] )
		return ERR_INVALID_DATA


	var spriteFrame = SpriteFrames.new()
	for animation_name in sheet.get_animation_names():
		if !spriteFrame.has_animation(animation_name):
			spriteFrame.add_animation(animation_name)

		for frame in sheet.get_animation(animation_name):
			var frameTexture = AtlasTexture.new()
			frameTexture.set_atlas(texture)
			frameTexture.set_region(frame.rect)
			spriteFrame.add_frame(animation_name, frameTexture)


	error = ResourceSaver.save( target_path, spriteFrame )
	if error != OK:
		print( str( ERRMSG_SAVE_STRF % target_path, ERRMSG_POSTCODE_STRF % error ))
		return ERR_INVALID_PARAMETER

	return OK
