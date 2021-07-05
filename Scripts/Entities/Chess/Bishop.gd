extends ChessEntity

class_name Bishop

func build_check_spots():
	var check_spots = [
		Direction.UpRight,
		Direction.UpLeft,
		Direction.DownRight,
		Direction.DownLeft
	]
	return check_spots
