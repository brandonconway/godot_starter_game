extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 200
var jumpForce = 400
var gravity = 1000
var health = 20

var vel = Vector2()
var grounded = false

onready var sprite = $Sprite
onready var sprite_hit = $SpriteHit
onready var bounds = get_node('/root/MainScene/Bounds')

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	vel.x = 0
	
	if Input.is_action_pressed("ui_left"):
		vel.x -= speed
	if Input.is_action_pressed("ui_right"):
		vel.x += speed
		
	
	vel = move_and_slide(vel, Vector2.UP)
	
	vel.y += gravity * delta
	if position.x >= bounds.scale.x:
		position.x = bounds.scale.x;
	if position.x <= 0:
		position.x = 0
	
	if Input.is_action_pressed('space'):
		if is_on_floor():
			vel.y -= jumpForce
		

func hit (damage):
	sprite_hit.show()
	var timer = Timer.new()
	timer.connect("timeout", self, "_on_timer_timeout") 
	timer.set_wait_time(0.3)
	add_child(timer) #to process
	timer.start() 
	health -= damage
	if health <= 0:
		# start level over
		var currentScene = get_tree().get_current_scene().get_filename()
		get_tree().change_scene(currentScene)

func _on_timer_timeout():
	sprite_hit.hide()
