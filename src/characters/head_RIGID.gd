extends RigidBody2D

@export var attatched_offset = Vector2(-4, 0)

@export var attatched = true
@export var speed = 1500
@export var accel = 75000

@export var max_health = 100
@export var health = 50
@export var damage_per_second = 100
@export var self_damage_on_hit = 20
@export var snapback_damage = 1000
@export var head_radius = 250

signal head_dead
func _ready():
	$AnimatedSprite2D.modulate = Color(.8, .8, .8)
func _physics_process(delta):
	# Handle splitting head
	if get_node("HeadCooldownTimer").is_stopped():
		
		$AnimatedSprite2D.modulate = Color(1, 1, 1)

		
func self_damage():
	health -= self_damage_on_hit
	if health <= 0:
		head_dead.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Unattatched, so do running around things
	#if not attatched and get_node("HeadAttackTimer").is_stopped():
	var collider = get_node("Area2D")
	if collider.has_overlapping_bodies():
		var body = collider.get_overlapping_bodies().pop_front()
		if body and body.has_method("take_damage"):
			body.take_damage(100 * get_node("HeadAttackTimer").wait_time)
			self_damage()
			get_node("HeadAttackTimer").start()
	if collider.has_overlapping_areas():
		var body = collider.get_overlapping_areas().pop_front()
		if body:
			body = body.get_parent()
		#print(body)
			if body.has_method("block_attack"):
				body.block_attack()
				self_damage()
				get_node("HeadAttackTimer").start()

func _on_body_entered(body):
	# Attatched but not yet back on our body, so do big damage
	if attatched and top_level and body.has_method("take_damage"):
		body.take_damage(snapback_damage)


func _on_head_cooldown_timer_timeout():
	$AnimatedSprite2D.modulate = Color(1, 1, 1)
