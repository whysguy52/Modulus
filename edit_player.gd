extends Node3D

#primitives
var isMouseCaptured

#references
var CollisionTarget
var targetSpot
var cockpit
var speed = 0.1


func _ready():

  Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
  cockpit = get_parent().get_node("cockpit")
  cockpit.rotation = Vector3.ZERO
  cockpit.transform.origin = Vector3.ZERO
  isMouseCaptured = true
  targetSpot = $TargetPoint

func _process(delta):

  if $Camera3D/RayCast3D.get_collider() != null:
    $TargetPoint.global_position = $Camera3D/RayCast3D.get_collision_point()
    $TargetPoint.visible = true
    var collision_object = $Camera3D/RayCast3D.get_collider()
    var shouldPlace = collision_object.name.contains("mount_point") and !collision_object.name.contains("invalid") and Input.is_action_just_pressed("mouse_lmb")
    var shouldDelete = collision_object.name.contains("mount_point") and !collision_object.name.contains("invalid") and Input.is_action_just_pressed("mouse_rmb")

    if (shouldPlace):
      #create new module
      var ModuleInstance = get_next_module()
      if ModuleInstance != null:
        cockpit.add_child(ModuleInstance)
        #place on collision box center, move by 1 in x direction, rotate +90 on x
        ModuleInstance.global_transform.origin = collision_object.global_transform.origin
        ModuleInstance.translate(collision_object.global_transform.basis.x)
        ModuleInstance.look_at(collision_object.get_parent().get_parent().transform.origin)
        ModuleInstance.rotate(ModuleInstance.global_transform.basis.x,PI/2)

      #ModuleInstance.global_transform.basis.look
    elif(shouldDelete):
      var TargetDelete = collision_object.get_parent().get_parent()
      TargetDelete.get_parent().remove_child(TargetDelete)
      get_node("Camera3D/inventory").add_child(TargetDelete)
      TargetDelete.transform.origin = Vector3.ZERO
      TargetDelete.rotation_degrees = Vector3.ZERO
    else:
      pass
  else:
    $TargetPoint.visible = false


func _physics_process(delta):
  var movement:Vector3

  movement = movement()

  translate(movement.normalized()*speed)

func get_next_module():
  if $Camera3D/inventory.get_children().size() > 0:
    var toMove = $Camera3D/inventory.get_children()[0]
    toMove.get_parent().remove_child(toMove)
    return toMove
  else:
    return null

func movement():

  var movement_z = $Camera3D.transform.basis.z*(int(Input.is_action_pressed("ui_backward")) - int(Input.is_action_pressed("ui_forward")))
  var movement_x = $Camera3D.transform.basis.x*(int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")))
  var movement_y = $Camera3D.transform.basis.y*(int(Input.is_action_pressed("ui_up")) - int(Input.is_action_pressed("ui_down")))

  var movement = movement_x + movement_y + movement_z
  movement = movement
  return movement


func _input(event):
  if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
    rotate_y(-event.screen_relative.x/180)
    get_node("Camera3D").rotate_x(-event.screen_relative.y/180)
    $Camera3D.rotation_degrees.x = clampf($Camera3D.rotation_degrees.x, -90, 90)

  if event.is_action_pressed("ui_cancel"):
    isMouseCaptured = !isMouseCaptured
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED * int(isMouseCaptured)
