extends TextureButton

enum Direction {
	Left,
	Right
}

export(Direction) var direction

func _pressed():
	print(direction)
