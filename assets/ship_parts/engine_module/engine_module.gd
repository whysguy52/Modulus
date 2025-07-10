extends "res://assets/ship_parts/base_module/base_module_script.gd"



func _ready():
  set_local_texture()
  return

  var scene = load("res://assets/ship_parts/base_module/base_module.tscn")
  var scene_dup = scene.duplicate(true)
  var local_instance = scene_dup.instantiate()
  add_child(local_instance)
  set_local_texture()
