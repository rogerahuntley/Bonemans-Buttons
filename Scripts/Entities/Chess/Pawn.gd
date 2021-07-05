extends ChessEntity

class_name Pawn

func build_check_spots():
	var check_spots: Array
	if current_direction == Direction.Up || current_direction == Direction.Right:
		check_spots.push_back(Direction.UpRight)
	if current_direction == Direction.Up || current_direction == Direction.Left:
		check_spots.push_back(Direction.UpLeft)
	if current_direction == Direction.Down || current_direction == Direction.Right:
		check_spots.push_back(Direction.DownRight)
	if current_direction == Direction.Down || current_direction == Direction.Left:
		check_spots.push_back(Direction.DownLeft)
	return check_spots
