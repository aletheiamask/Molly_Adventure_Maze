extends Node2D

# Declare the Dialogic node
@onready var dialogic = $Dialogic
var special_item_count = 0

func _ready():
	# Connect the signal from Dialogic to a custom function
	Dialogic.signal_event.connect(_on_dialogic_signal)
	
	# ตรวจสอบไอเทมที่เก็บได้ทุกครั้งที่เริ่มเกม
	check_special_items()

# This function will be called when the signal is emitted from Dialogic
func _on_dialogic_signal(argument: String):
	if argument == "Restart_Game":
		# Load the game scene when the signal argument is "Restart_Game"
		get_tree().reload_current_scene()

# ฟังก์ชันตรวจสอบจำนวนไอเทมพิเศษ
func check_special_items():
	if special_item_count == 6:
		# เมื่อไอเทมครบ 6 ชิ้น เรียกใช้ฟังก์ชันเริ่ม Timeline "ตอนจบ"
		start_end_timeline()

# ฟังก์ชันเริ่ม Timeline "ตอนจบ"
func start_end_timeline():
	# เรียกใช้ signal_event ใน Dialogic เพื่อเริ่ม Timeline "ตอนจบ"
	dialogic.signal_event.emit("start_end_timeline")
