extends CharacterBody2D

@onready var animation: AnimationPlayer = $AnimationPlayer


@export var speed: float = 80.0
enum state {IDLE_RIGHT, IDLE_LEFT, IDLE_UP, IDLE_DOWN, WALK_RIGHT, WALK_LEFT, WALK_UP, WALK_DOWN}
var player_state = state.IDLE_RIGHT
var input:Vector2 = Vector2.ZERO

func update_animation() -> void:
	match(player_state):
		state.IDLE_RIGHT:
			animation.play("idle R")
		state.IDLE_LEFT:
			animation.play("idle L")
		state.IDLE_UP:
			animation.play("idle back")
		state.IDLE_DOWN:
			animation.play("idle front")
		state.WALK_RIGHT:
			animation.play("walk R")
			player_state = state.IDLE_RIGHT
		state.WALK_LEFT:
			animation.play("walk L")
			player_state = state.IDLE_LEFT
		state.WALK_UP:
			animation.play("walk back")
			player_state = state.IDLE_UP
		state.WALK_DOWN:
			animation.play("front walk")
			player_state = state.IDLE_DOWN
		

func _process(delta: float) -> void:
	movement(delta)

func movement(delta:float) -> void:
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	input.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	
	if(Input.is_action_pressed("left")):
		player_state = state.WALK_LEFT
	if Input.is_action_pressed("right"):
		player_state = state.WALK_RIGHT
	if Input.is_action_pressed("down"):
		player_state = state.WALK_DOWN
	if Input.is_action_pressed("up"):
		player_state = state.WALK_UP
		
	
	input = input.normalized();
	velocity = input * speed
	move_and_slide()
	update_animation()
