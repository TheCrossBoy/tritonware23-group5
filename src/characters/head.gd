extends CharacterBody2D

@export var attatched_offset = Vector2(0, -40)
@export var speed = 1500
@export var accel = 75000

@export var max_health = 100
@export var health = 100
@export var damage_per_second = 100
@export var self_damage_on_hit = 20
@export var snapback_damage = 50
@export var head_radius = 250

var head_rigid = preload("res://src/characters/head_RIGID.tscn")
var h
var head_state = 0
#0 is attatched, 1 is free moving, 2 is reattaching
func _ready():
	position = attatched_offset
func _physics_process(delta):
	# Handle splitting head
	if Input.is_action_just_pressed("head_split") && get_node("HeadCooldownTimer").is_stopped():
		
		get_node("HeadCooldownTimer").start()
		$AnimatedSprite2D.modulate = Color(.8, .8, .8)
		
		if head_state == 1:
			# Start reattatching process
			head_state = 2
			position = h.global_position
			h.queue_free()
			visible = true
		elif head_state == 0 :
			# Start detatching process
			top_level = true
			position = get_parent().position + attatched_offset
			health = max_health
			head_state = 1
			
			#SPAWN RIGID HEAD
			get_parent().get_node("HeadSpawner").set_position(global_position)
			h = head_rigid.instantiate()
			h.head_dead.connect(_on_head_dead)
			get_parent().get_node("HeadSpawner").add_child(h)
			var target_pos
			target_pos = get_viewport().get_mouse_position()
			h.apply_impulse((target_pos - global_position).normalized()*1500, Vector2()) 
			h.apply_torque_impulse(100) #get a little spin on that boi too
			visible = false #HIDE CHARACTERBODY HEAD
	
	# Move towards target
	if top_level:
		var target_pos = get_parent().position + attatched_offset
			
		if (target_pos - position).length() < speed * delta:
			if head_state == 0:
				top_level = false
				position = attatched_offset
			elif head_state == 2:
				position = target_pos
				head_state = 0
				get_node("HeadCooldownTimer").start()
		else:	#gradually move to target_pos
			position += (target_pos - position).normalized() * accel * delta * delta
		
func _on_head_dead():
	head_state = 2
	position = h.global_position
	h.queue_free()
	visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	# Unattatched, so do running around things
#	if head_state == 1 and get_node("HeadAttackTimer").is_stopped():
#		var collider = get_node("Area2D")
#		if collider.has_overlapping_bodies():
#			var body = collider.get_overlapping_bodies()[0]
#			if body.has_method("take_damage"):
#				body.take_damage(100 * get_node("HeadAttackTimer").wait_time)
#				self_damage()
#				get_node("HeadAttackTimer").start()
#		if collider.has_overlapping_areas():
#			var body = collider.get_overlapping_areas()[0].get_parent()
#			print(body)
#			if body.has_method("block_attack"):
#				body.block_attack()
#				self_damage()
#				get_node("HeadAttackTimer").start()


func _on_head_cooldown_timer_timeout():
	$AnimatedSprite2D.modulate = Color(1, 1, 1)


func _on_area_2d_body_entered(body):
	if head_state == 2 and top_level and body.has_method("take_damage"):
		body.take_damage(snapback_damage)
