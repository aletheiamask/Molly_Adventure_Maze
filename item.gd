extends Area2D

@export var item_name: String = "default_item"  # กำหนดชื่อไอเท็ม
@export var collect_animation: String = "Collect_Default"  # ตั้งค่าแอนิเมชันที่ใช้

func _ready():
	connect("body_entered", _on_body_entered)  # เชื่อม Event เมื่อตรวจจับผู้เล่นเข้าในพื้นที่

func _on_body_entered(body):
	if body.is_in_group("player"):  # ตรวจสอบว่าผู้เล่นเข้ามา
		collect()

func collect():
	if $AnimationPlayer.has_animation(collect_animation):
		$AnimationPlayer.play(collect_animation)  # เล่นแอนิเมชันที่กำหนด
		await $AnimationPlayer.animation_finished  # รอให้แอนิเมชันเล่นจบ
	queue_free()  # ทำลายไอเท็มหลังเล่นแอนิเมชันเสร็จ
