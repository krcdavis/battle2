extends Sprite2D

@onready var hpbar = $TextureProgressBar
@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	settext("sdghcgj")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func settext(tt = "aaa"):
	label.text = tt

func sethp(maxm,val):
	hpbar.max_value = maxm
	hpbar.value = val
	

func updhp(val):
	hpbar.value = val
