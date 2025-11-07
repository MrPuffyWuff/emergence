extends Node3D

@onready var camera : Camera3D = $CameraPivot/SpringArm3D/Camera3D
@export var CAMERA_TURN_SPEED : float = 0.01
@export var Y_CAM_RANGE_CLAMP : Vector2 = Vector2(-PI/2,PI/2)
@export var CAMERA_ZOOM_SPEED : float = 0.5
@export var CAMERA_RANGE_CLAMP : Vector2 = Vector2(1,200)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		#Only Pan if "camera_pan"
		#if not Input.is_action_pressed("camera_pan"):
			#return
		#mouse_dir is the velocity basically. NOT POSITION (I made that mistake...)
		var mouse_dir : Vector2 = event.relative
		#Offset the Pivot. This helps lock the camera local rotation to face the helicopter
		$CameraPivot.rotation.x -= mouse_dir.y * CAMERA_TURN_SPEED
		$CameraPivot.rotation.x = clamp($CameraPivot.rotation.x,Y_CAM_RANGE_CLAMP.x ,Y_CAM_RANGE_CLAMP.y)
		$CameraPivot.rotation.y -= mouse_dir.x * CAMERA_TURN_SPEED
		$CameraPivot.transform = $CameraPivot.transform.orthonormalized()
	elif event is InputEventMouseButton:
		#Zoom stuff
		if event.is_pressed():
			#Using a spring allows it to shrink upon contact with a CollisionShape
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				$CameraPivot/SpringArm3D.spring_length -= CAMERA_ZOOM_SPEED
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				$CameraPivot/SpringArm3D.spring_length += CAMERA_ZOOM_SPEED
			$CameraPivot/SpringArm3D.spring_length = clamp($CameraPivot/SpringArm3D.spring_length, CAMERA_RANGE_CLAMP.x, CAMERA_RANGE_CLAMP.y)
