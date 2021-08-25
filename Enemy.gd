extends KinematicBody2D


var vel = Vector2()
var health = 20
var gravity = 1200
var damage = 2 
var can_hit = true
var rng

onready var normal_sprite = $enemy
onready var range_sprite = $enemy_red
# Called when the node enters the scene tree for the first time.
func _ready():
	#for fun we randomize the velocity of the bad guy
	rng = RandomNumberGenerator.new()
	rng.randomize()
	vel.x = rng.randi_range(200, 500) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if self.health <= 0:
		self.free()

func _physics_process(delta):
	vel.y += gravity * delta
	var collision = move_and_collide(vel * delta)
	if collision:
		if collision.collider.has_method('hit') && can_hit:
			collision.collider.hit(damage)
			# add a 'cool down' timer (can only hit you once a second
			can_hit = false
			var timer = Timer.new()
			timer.connect("timeout",self,"_on_timer_timeout") 
			timer.set_wait_time(1) # 1 second
			add_child(timer) #to process
			timer.start() 
		# bounce
		vel = vel.bounce(collision.normal)

	
func _on_timer_timeout ():
	can_hit = true

func show_in_range(show):
	if show:
		normal_sprite.hide()
		range_sprite.show()
	else:
		normal_sprite.show()
		range_sprite.hide()

