extends ship
class_name Player

export var SensorRanger = 100.0
export var mouse_sens = 0.5

onready var camera = $Camera
onready var sensors = $Sensor


#Local Class Properties
var exsel = 128
var dead = false
var mov_dir = Vector3()
var target
var hotkeys = {
	KEY_1: 0,
	KEY_2: 1,
	KEY_3: 2,
	KEY_4: 3,
	KEY_5: 4,
	KEY_6: 5,
	KEY_7: 6,
	KEY_8: 7,
	KEY_9: 8,
	KEY_0: 9,
}


# Called when the node enters the scene tree for the first time.
func _ready():	
	get_tree().call_group("hive","set_player", self)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta):
#	pass 

func set_target():
	target = sensors.get_collider()

func auto_target():
	if sensors.get_collider() and sensors.is_in_group("hive"):
		set_target()

func _process(_delta):
	get_tree().call_group("hive","set_player", self)
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
	if dead:
		return
	
	var move_vec = Vector3()
	if Input.is_action_pressed("MoveForward"):
		move_vec += transform.basis.z
	if Input.is_action_pressed("MoveBackward"):
		move_vec += -transform.basis.z
	if Input.is_action_pressed("MoveLeft"):
		move_vec += transform.basis.x
	if Input.is_action_pressed("MoveRight"):
		move_vec += -transform.basis.x
	if Input.is_action_pressed("roll_left"):
		rotate_object_local(Vector3.FORWARD, .05)
	if Input.is_action_pressed("roll_right"):
		rotate_object_local(Vector3.FORWARD,-.05)
	if Input.is_action_pressed("rotate_left"):
		rotate_object_local(Vector3.UP, .05)
	if Input.is_action_pressed("rotate_right"):
		rotate_object_local(Vector3.UP, -.05)
	if Input.is_action_pressed("rotate_down"):
		rotate_object_local(Vector3.RIGHT, .05)
	if Input.is_action_pressed("rotate_up"):
		rotate_object_local(Vector3.RIGHT, -.05)
	
	Movement.set_move_vec(move_vec)

# Handle mouse and controler plus touch input
##func _input(event):
##	if event is InputEventMouseMotion or InputEventJoypadMotion:
##		rotation_degrees.y -= mouse_sens * event.relative.x
##		rotation_degrees.x += mouse_sens * event.relative.y
#
#
#
##	if event is InputEventKey and event.pressed:
##		if event.scancode in hotkeys:
##			Weapons.switch_to_weapon_slot(hotkeys[event.scancode])
##	if event is InputEventMouseButton and event.pressed:
##		if event.button_index == BUTTON_WHEEL_DOWN:
##			Weapons.switch_to_next_weapon()
##		if event.button_index == BUTTON_WHEEL_UP:
##			Weapons.switch_to_last_weapon()

func hurt(damage, dir):
	Health.hurt(damage, dir)

func heal(amount):
	Health.heal(amount)

func kill():
	dead = true
	Movement.freeze()


# Replace with function body.
