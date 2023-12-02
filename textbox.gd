extends NinePatchRect

@onready var textbox = $RichTextLabel
@onready var speed = $RichTextLabel/Timer
@onready var countdown = $RichTextLabel/Timer2
@onready var sprite = $RichTextLabel/arrow

@export var textSpeed = .03
@export var wait = .25#button mash wait
var disable_text_enter_clearing = false

var finished = false

signal textover

#replace self.visible with textbox.visible 

func _ready():
	countdown.set_one_shot(true)
	countdown.start(0.00001)#i don't remember why this is here
	countdown.wait_time = wait
	speed.wait_time = textSpeed
	sprite.visible=false
	
	finished = false
	#?
	self.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#just checks for finished, whether enter-induced or 'natural'
	if countdown.time_left <= 0:
		if !disable_text_enter_clearing:#ie do not disable
			sprite.visible=finished
		if Input.is_action_just_pressed("ui_accept"):# and !disable_text_enter_clearing:
			if !finished:
				pass
				textbox.visible_characters = len(textbox.text)
				#wait for a bit before allowing reset
				countdown.start(wait)
			else:
				#reset...
				if !disable_text_enter_clearing:#ie do not disable
					#lmaooooo
					self.visible=false#this should be kept for other uses though... visible=nohideflag
				emit_signal("textover")
		
		

func immediate_text(textdata):
	#wait a tick before loading it, then mark finished?
	pass
	finished = false
	sprite.visible=finished
	textbox.bbcode_text = textdata
	textbox.visible_characters = len(textbox.text) #-1?

func textplay(textdata, disable = false):#
	#for now just pass in plain text
	finished = false
	sprite.visible=finished
	disable_text_enter_clearing = disable
	#$Timer.wait_time = _tsx
	self.visible = true
	textbox.bbcode_text = textdata
	textbox.visible_characters = 0
	
	#then fix all of this
	while textbox.visible_characters < len(textbox.text):
		textbox.visible_characters += 1
		#$Timer.start()
		#yield($Timer, "timeout")
		speed.start()
		await speed.timeout
	finished = true

func texthide():
	self.visible = false
