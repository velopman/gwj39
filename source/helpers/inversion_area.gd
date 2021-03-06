class_name InversionArea


# Private variables

var top_left: Vector2 = Vector2.ZERO
var bottom_right: Vector2 = Vector2.ZERO

var internal_positions: Array = []


# Lifecycle methods

func _init(top_left: Vector2, bottom_right: Vector2) -> void:
	self.top_left = top_left
	self.bottom_right = bottom_right

	var delta: Vector2 = self.bottom_right - self.top_left

	for y in range(1.0, delta.y):
		for x in range(1.0, delta.x):
			self.internal_positions.append(self.top_left + Vector2(x, y))


# Public methods

func contains_area(area: InversionArea) -> bool:
	return (
		self.top_left.x <= area.top_left.x &&
		self.top_left.y <= area.top_left.y &&
		self.bottom_right.x >= area.bottom_right.x &&
		self.bottom_right.y >= area.bottom_right.y
	)

func contains_position(position: Vector2) -> bool:
	return (
		self.top_left.x <= position.x &&
		self.top_left.y <= position.y &&
		self.bottom_right.x >= position.x &&
		self.bottom_right.y >= position.y
	)


func contains_position_border(position: Vector2) -> bool:
	return self.contains_position(position) && !self.contains_position_internally(position)


func contains_position_internally(position: Vector2) -> bool:
	return (
		self.top_left.x < position.x &&
		self.top_left.y < position.y &&
		self.bottom_right.x > position.x &&
		self.bottom_right.y > position.y
	)
