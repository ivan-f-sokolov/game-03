extends Area2D

signal hit

@export var speed = 400
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play()
	# hide()

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.animation = "walk"
	else:
		$AnimatedSprite2D.animation = "idle"

	position += velocity * delta

	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0

func _on_Player_body_entered(body):
	hide() # Player disappears aftebeing hit.
	emit_signal("hit")
	# Must be deferred as we can't change physics properties checked a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
