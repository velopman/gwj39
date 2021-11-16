extends Control


# Private variables

onready var __player_panes: Array = [
	$player_1_pane,
	$player_2_pane,
	$player_3_pane,
	$player_4_pane,
]

onready var __button_back: Button = $back
onready var __button_start: Button = $start


var __control_interfaces: Array = [
	ControlInterface.new(ControlInterface.TOUCH),
	ControlInterface.new(ControlInterface.KEYBOARD_1),
	ControlInterface.new(ControlInterface.KEYBOARD_2),
	ControlInterface.new(ControlInterface.CONTROLLER_1),
	ControlInterface.new(ControlInterface.CONTROLLER_2),
	ControlInterface.new(ControlInterface.CONTROLLER_3),
	ControlInterface.new(ControlInterface.CONTROLLER_4),
]
var __active_interfaces: Array = []


# Lifecylce methods

func _ready()-> void:
	self.__button_start.connect("pressed", self, "__start_pressed")
	self.__button_back.connect("pressed", self, "__back_pressed")


func _process(delta: float) -> void:
	var player_count = self.__active_interfaces.size()
	if player_count == 4:
		return

	for interface in self.__control_interfaces:
		interface.process()

		if interface.is_active() && !interface.is_assigned():
			interface.assign()

			# Give interface to the current pane
			self.__player_panes[player_count].activate(interface.interface())

			self.__active_interfaces.append(interface.interface())

			if self.__active_interfaces.size() == 1:
				self.__button_start.disabled = false
				self.__button_start.grab_focus()


# Private methods

func __start_pressed() -> void:
	SceneManager.load_scene("main")


func __back_pressed() -> void:
	SceneManager.load_scene("menu")
