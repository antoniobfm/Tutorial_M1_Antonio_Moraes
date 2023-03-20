extends KinematicBody2D

var player: KinematicBody2D = null

export var speed = 20

var velocity := Vector2.ZERO
var timer = Timer.new()

var damage = 1

func _on_PlayerDetector_body_entered(body):
	if body.name == 'Player':
		$AnimatedSprite.play("Attack")
		player.receive_hit(1)

func _ready():
	player = get_parent().get_node('Player')
	
	add_child(timer)
	timer.set_wait_time(0.3)
	timer.set_one_shot(false)
	timer.connect("timeout", self, "_on_Timer_timeout")
	
func _on_Timer_timeout():
	$Audio.play()
	
func _physics_process(delta):
	if !Engine.editor_hint:
		move(delta)
	
func move(delta):
	var player_position = player.position
#	rotation = position.angle_to_point(player.global_position) - deg2rad(90)
	if player != null && position.distance_to(player_position) < 50:
		$AnimatedSprite.play("Running")
		if timer.is_stopped():
			timer.start()
		velocity = global_position.direction_to(player.global_position)
		global_position += velocity * speed * delta
	else:
		$AnimatedSprite.play("Idle")
		timer.stop()
		
	velocity = move_and_slide(velocity)

