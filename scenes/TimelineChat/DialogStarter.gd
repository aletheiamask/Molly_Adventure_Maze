extends Area2D

# กำหนดทามไลน์ที่ต้องการให้แสดงในพื้นที่นี้
@export var timelines: Array = [
	"new_hope",  # ชื่อของทามไลน์ที่ใช้ใน Dialogic
	"beware",
	"you_win"
]

var dialog_shown: Dictionary = {}  # ใช้ Dictionary เพื่อเก็บสถานะของแต่ละทามไลน์
@onready var dialogic = $Dialogic
var score = 0

func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	for timeline in timelines:
		dialog_shown[timeline] = false

# ฟังก์ชันสำหรับตรวจสอบและเริ่มทามไลน์
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		# ตรวจสอบทามไลน์ทั่วไป
		for timeline in timelines:
			if timeline != "you_win":  # ตรวจสอบทามไลน์ที่ไม่ใช่ "you_win"
				if not dialog_shown[timeline]:  # ถ้ายังไม่แสดงทามไลน์นี้
					print("Player entered, starting dialog for timeline: ", timeline)
					Dialogic.start(timeline)  # เริ่มทามไลน์ที่กำหนด
					dialog_shown[timeline] = true  # ตั้งสถานะว่าได้แสดงแล้ว
					break  # หากเริ่มทามไลน์แรกแล้วไม่ต้องตรวจสอบทามไลน์อื่น ๆ

		# เฉพาะทามไลน์ "you_win" ที่ต้องตรวจสอบคะแนน
		if "you_win" in timelines:
			if score == 6 and not dialog_shown["you_win"]:  # ตรวจสอบคะแนนก่อน
				print("Player entered 'you_win', starting dialog for 'you_win' timeline.")
				Dialogic.start("you_win")  # เริ่มทามไลน์ 'you_win'
				dialog_shown["you_win"] = true  # ตั้งสถานะว่าได้แสดงแล้ว
			elif score != 6:
				Dialogic.start("exp")
				print("คะแนนยังไม่ถึง 6, ไม่สามารถเริ่มทามไลน์ 'you_win' ได้.")

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		print("Player exited the area.")
		# สามารถเพิ่มการทำงานเพิ่มเติมเมื่อผู้เล่นออกจากพื้นที่
		
func _on_dialogic_signal(argument: String):
	if argument == "string1" or argument == "string2" or argument == "string3" or argument == "string4" or argument == "string5" or argument == "string6":
		score += 1  # เพิ่มคะแนนทีละ 1
		print("คะเนนเพื่ม.")
	elif score == 6:  # ถ้าคะแนนครบ 6
			print("ตอนจบ")
