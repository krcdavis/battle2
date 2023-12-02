extends HSlider

@export var busname: String
var busindex: int

# Called when the node enters the scene tree for the first time.
func _ready():
	
	busindex = AudioServer.get_bus_index(busname)
	value_changed.connect(_on_vol_ch)
	set_value(.75)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_vol_ch(value: float):
	print(value)
	AudioServer.set_bus_volume_db( busindex, linear_to_db(value) )
