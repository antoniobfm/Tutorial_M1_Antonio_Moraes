extends KinematicBody2D

var running = false

var timer = Timer.new()
var hitTime = Timer.new()
var health = 3;

var just_hit = false
signal health_changed(old_value, new_value)

func _ready():
	add_child(timer)
	add_child(hitTime)
	timer.set_wait_time(0.3)
	timer.set_one_shot(false)
	timer.connect("timeout", self, "_on_Timer_timeout")
	
	hitTime.set_wait_time(3)
	hitTime.set_one_shot(false)
	hitTime.connect("timeout", self, "_on_Hit_timeout")
	

func _on_Timer_timeout():
	$Audio.play()
	
func _on_Hit_timeout():
	just_hit = false
	hitTime.stop()
	
func receive_hit(damage):
	if !just_hit:
		just_hit = true
		emit_signal("health_changed", health, health - damage)
		health -= damage
		
		if hitTime.is_stopped():
			$AudioHit.play()
			hitTime.start()
			
func _process(delta):
	if health == 0:
		get_tree().change_scene("res://Lost.tscn")
	
func _physics_process(delta):
	running = false
	var pressing = false
	
	if just_hit:
		# Halve opacity every uneven frame counts
		self.modulate.a = 0.5 if Engine.get_frames_drawn() % 2 == 0 else 1.0
	else:
		# But beware... if the last damage frame is not even,
		# you risk to leave your character half transparedWnt!
		# Preferably do this when you set your flag back to false
		self.modulate.a = 1.0
	
	#player speed
	var vectorMovement = Vector2.ZERO
	#Define player direction
	vectorMovement.x =Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	vectorMovement.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if(Input.is_action_pressed("Run")):
		running = true
		
	#change the animation while change the player direction
	if(Input.is_action_pressed("ui_right")):
		pressing = true
		$AnimatedSprite.flip_h = false
	elif(Input.is_action_pressed("ui_left")):
		pressing = true
		$AnimatedSprite.flip_h = true
	elif(Input.is_action_pressed("ui_down")):
		pressing = true
	elif(Input.is_action_pressed("ui_up")):
		pressing = true
	else:
		#stop the player
		timer.stop()
		$AnimatedSprite.play("Idle")
		#Move the player
		
	var speed = 50
	if (running && pressing):
		timer.set_wait_time(0.2)
		$AnimatedSprite.play("Running")
		if timer.is_stopped():
			timer.start()
		speed = 40
	elif (pressing):
		timer.set_wait_time(0.3)
		$AnimatedSprite.play("Walking")
		if timer.is_stopped():
			timer.start()
		
	move_and_slide(vectorMovement*speed)
