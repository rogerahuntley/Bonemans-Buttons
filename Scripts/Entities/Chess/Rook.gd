extends ChessEntity

class_name Rook

func build_check_spots():
	var check_spots = [
		Direction.Up,
		Direction.Right,
		Direction.Down,
		Direction.Left
	]
	return check_spots
