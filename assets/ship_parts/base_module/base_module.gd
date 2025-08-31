extends StaticBody3D

func _ready():
  return
  var blend_file = preload("res://assets/ship_parts/base_module/base_module.blend")
  var blend_dup = blend_file.duplicate(true)
  var blend_inst = blend_dup.instantiate()
  add_child(blend_inst)

  pass
