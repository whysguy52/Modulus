extends "res://assets/ship_parts/base_module/base_module_script.gd"



func _ready():
  #set_local_texture()
  #return

  var scene = load("res://assets/ship_parts/base_module/base_module.tscn")
  var scene_dup = scene.duplicate(true)
  scene_dup.resource_local_to_scene = true
  var local_instance = scene_dup.instantiate()
  add_child(local_instance)
  print(scene_dup.resource_local_to_scene)
  set_local_texture()
