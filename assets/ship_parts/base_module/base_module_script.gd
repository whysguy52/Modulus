extends StaticBody3D

func set_local_texture():
  var currentDir = DirAccess.open(scene_file_path.get_base_dir())
  currentDir.change_dir("textures")
  var fileList = currentDir.get_files()
  var totalTexturePath = currentDir.get_current_dir() + "/" + fileList[0]
  var textImage = load(totalTexturePath)
  var text_resource = get_node("base_module").get_node("base_module").get_node("Cube").get_active_material(0)
  text_resource.albedo_texture.resource_local_to_scene = true
  text_resource.set("albedo_texture", textImage)
