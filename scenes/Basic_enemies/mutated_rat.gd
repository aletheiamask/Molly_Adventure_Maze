extends CharacterBody2D

const MAX_SPEED = 50
const SPRINT_SPEED = 100  # ความเร็วสูงสุดเมื่อศัตรูเร่ง
const VIEW_DISTANCE = 150  # ระยะที่ศัตรูสามารถมองเห็นผู้เล่น
const MIN_DISTANCE = 20  # ระยะห่างขั้นต่ำที่ศัตรูจะหยุดเคลื่อนที่
var direction = Vector2.ZERO  # ทิศทางการเคลื่อนที่ของศัตรู

# เรียกทำงานครั้งแรก
func _ready():
	$AnimationPlayer.play("idle")  # เริ่มด้วยอนิเมชัน Idle

# ฟังก์ชันสุ่มการเบี่ยงเบนของการเคลื่อนที่
func get_random_offset():
	return Vector2(randi_range(-10, 10), randi_range(-10, 10))

# ฟังก์ชันฟิสิกส์ (เรียกทุกเฟรมฟิสิกส์)
func _physics_process(_delta):  
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node:
		var player_position = player_node.global_position
		var distance = global_position.distance_to(player_position)
		
		# หากผู้เล่นอยู่ในระยะสายตา
		if distance < VIEW_DISTANCE and distance > MIN_DISTANCE:
			# เร่งความเร็ว (SPRINT_SPEED)
			var move_direction = (player_position - global_position).normalized()
			velocity = move_direction * SPRINT_SPEED
			move_and_slide()
			play_anim(move_direction)  # เล่นอนิเมชันตามทิศทาง
		elif distance <= MIN_DISTANCE:  
			# หยุดเมื่อใกล้เกินไป
			velocity = Vector2.ZERO
			play_anim(Vector2.ZERO)  # เล่นอนิเมชัน Idle
		else:
			# อยู่นอกระยะสายตา (หยุดหรือเคลื่อนที่ปกติ)
			velocity = Vector2.ZERO
			play_anim(Vector2.ZERO)
	else:
		# หยุดเมื่อไม่พบผู้เล่น
		velocity = Vector2.ZERO
		play_anim(Vector2.ZERO)

# ฟังก์ชันเล่นอนิเมชันตามทิศทาง
func play_anim(dir):
	if dir == Vector2.ZERO:  # หยุดนิ่ง
		$AnimationPlayer.play("idle")
	elif abs(dir.x) > abs(dir.y):  # ตรวจทิศทางแนวนอน
		if dir.x > 0:
			$AnimationPlayer.play("right")  # ไปทางขวา
		else:
			$AnimationPlayer.play("left")  # ไปทางซ้าย
	else:  # ตรวจทิศทางแนวตั้ง
		if dir.y > 0:
			$AnimationPlayer.play("down")  # ไปทางลง
		else:
			$AnimationPlayer.play("up")  # ไปทางขึ้น
