extends CharacterBody2D

const SPEED = 100.0

func _physics_process(delta: float) -> void:
	# รับการเคลื่อนที่ในแนวแกน x และ y
	var direction_x := Input.get_axis("ui_left", "ui_right")
	var direction_y := Input.get_axis("ui_up", "ui_down")
	
	# กำหนดความเร็วในการเคลื่อนที่
	velocity.x = direction_x * SPEED
	velocity.y = direction_y * SPEED

	# เคลื่อนที่โดยใช้ move_and_slide โดยไม่ต้องใส่พารามิเตอร์ใด ๆ
	move_and_slide()
	
