extends Node2D

#i love dictionaries
#option options don't need data and this can be left blank, but
#move and party menus can both use this
var metadata = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	#print($Btloptn.texture)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#while arr visible, animate lightly jostling +-x
	pass

#func highlight on/off, change $Arr visibility
func highlight(setting = true):
	$Arr.visible = setting

func setlabel(st = "--"):
	$Label.text = st

func activate(act = false, string = "---"):
	setlabel(string)
	$Sprite2D2.visible = act


func add_data(key, thing):
	metadata[key] = thing

func get_data(key, default = null):
	return metadata.get(key, default)

func clear_data():
	metadata.clear()
