extends CharacterBody2D

# เพิ่มฟิลด์ใหม่ในคลาสของตัวละคร
var is_in_dialog: bool = false
var speed = 0
var player_state = "idle"
@onready var dialogic = $Dialogic
var special_item_count = 0



func _ready():
	add_to_group("Player")
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.start("you_win")

func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction == Vector2.ZERO:
		player_state = "idle"
	else:
		player_state = "walking"
	
	velocity = direction * speed
	move_and_slide()
	
	play_anim(direction)

func play_anim(dir: Vector2) -> void:
	# เล่นแอนิเมชันตามทิศทาง
	if player_state == "idle":
		$AnimationPlayer.play("IDLE")
	elif player_state == "walking":
		if dir.y == -1:
			$AnimationPlayer.play("IDLE")
		elif dir.y == 1:
			$AnimationPlayer.play("IDLE")
		elif dir.x == -1:
			$AnimationPlayer.play("IDLE")
		elif dir.x == 1:
			$AnimationPlayer.play("IDLE")

# This function will be called when the signal is emitted from Dialogic
func _on_dialogic_signal(argument: String):
	if argument == "stop":
		speed = 0
	elif argument == "run":
		speed = 150
		
