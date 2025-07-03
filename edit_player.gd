extends Node3D

var isMouseCaptured

var speed = 0.1


func _ready():
  Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta):

  var movement:Vector3

  movement = movement()

  translate(movement.normalized()*speed)

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
    print(event.screen_relative.x)
    get_node("Camera3D").rotate_x(-event.screen_relative.y/180)
    $Camera3D.rotation_degrees.x = clampf($Camera3D.rotation_degrees.x, -90, 90)

  if event.is_action_pressed("ui_cancel"):
    # 0 = visible, 2 = captured
    isMouseCaptured = !isMouseCaptured
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED * int(isMouseCaptured)
