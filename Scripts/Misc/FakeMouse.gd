# I limited this code to the bare minimum.
# With my Sprite, I had to offset a little bit so that the picture was center with the mouse.

extends Node2D

export(Vector2) var mouseOff 

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
		# Where I get the mouse position
	var mousePos = get_local_mouse_position() - (($Crosshair.get_rect().size / 4) * $Crosshair.scale) + mouseOff
	$Crosshair.position = mousePos
		# You can do other stuff with the mousePos and adjust anyway you need to
