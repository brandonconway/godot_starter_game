extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var weapon_range = 150
var damage = 5
var crosshair = load("res://crosshair.png")
var target = null

onready var ray = $WeaponCast

# Called when the node enters the scene tree for the first time.
func _ready():
	ray.cast_to = Vector2(weapon_range, 0)
	Input.set_custom_mouse_cursor(crosshair, 0, Vector2(16,16))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	ray.look_at(get_global_mouse_position())
	var distance = (get_local_mouse_position() - self.position).length()
	
	if ray.is_colliding():
		target = ray.get_collider()
		if target.is_in_group('enemy'):
			if target.has_method('show_in_range'):
				target.show_in_range(true)
			#Input.set_custom_mouse_cursor(crosshair, 0, Vector2(16, 16))
			if Input.is_action_just_pressed("left_mouse"):
				print('fire')
				target.health -= damage
	else: 
		if target is Node:
			if target.has_method('show_in_range'):
				target.show_in_range(false)

