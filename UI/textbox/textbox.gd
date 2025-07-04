extends CanvasLayer

@onready var textbox_container = $TextboxContainer
@onready var image_container = $ImageContainer
@onready var start_symbol = $TextboxContainer/MarginContainer/HBoxContainer/Start
@onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/End
@onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label


const CHAR_READ_RATE = 0.05

enum State{
	READY,
	READING,
	FINISHED
}

var current_state = null
var text_queue = []
var active_tween = null
signal dialog_started
signal dialog_finished
# Called when the node enters the scene tree for the first time.
func _ready():
	hide_textbox()
	current_state = State.READY

func _update_state():
	match current_state:
		State.READY:
			if !text_queue.is_empty():
				print("test: ", text_queue)
				display_text()
				emit_signal("dialog_started")
			pass
		State.READING:
			if Input.is_action_just_pressed("interact"):
				label.visible_characters = len(label.text)
				if active_tween != null:
					active_tween.stop() 
				end_symbol.text = "v"
				change_state(State.FINISHED)
			pass
		State.FINISHED:
			if Input.is_action_just_pressed("interact"):
				change_state(State.READY)
				hide_textbox()
				if(text_queue.is_empty()):
					emit_signal("dialog_finished")
			pass	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	_update_state()


func queue_text(new_text):
	if(current_state != State.FINISHED):
		text_queue.push_back(new_text)
		
	
func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	textbox_container.hide()
	image_container.hide()

func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()
	image_container.show()
	
func display_text():
	
	var next_text = text_queue.pop_front()
	label.text = next_text
	change_state(State.READING)
	show_textbox() 
	active_tween = get_tree().create_tween()
	active_tween.tween_property(label, "visible_characters", len(next_text), len(next_text) * CHAR_READ_RATE).from(0).finished
	active_tween.connect("finished", Callable(self, "on_tween_finished"))
	end_symbol.text = "..."
	
func on_tween_finished():
	end_symbol.text = "<-"
	change_state(State.FINISHED)

	
func change_state(next_state):
	current_state = next_state
	
func start_dialog():
	current_state = State.READY
