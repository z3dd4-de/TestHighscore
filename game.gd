extends Node2D

var highscore: Highscores
@onready var name_1_label = $CanvasLayer/HighscorePanel/VBoxContainer/GridContainer/Name1Label
@onready var points_1_label = $CanvasLayer/HighscorePanel/VBoxContainer/GridContainer/Points1Label
@onready var name_2_label = $CanvasLayer/HighscorePanel/VBoxContainer/GridContainer/Name2Label
@onready var points_2_label = $CanvasLayer/HighscorePanel/VBoxContainer/GridContainer/Points2Label
@onready var name_3_label = $CanvasLayer/HighscorePanel/VBoxContainer/GridContainer/Name3Label
@onready var points_3_label = $CanvasLayer/HighscorePanel/VBoxContainer/GridContainer/Points3Label
@onready var name_4_label = $CanvasLayer/HighscorePanel/VBoxContainer/GridContainer/Name4Label
@onready var points_4_label = $CanvasLayer/HighscorePanel/VBoxContainer/GridContainer/Points4Label
@onready var name_5_label = $CanvasLayer/HighscorePanel/VBoxContainer/GridContainer/Name5Label
@onready var points_5_label = $CanvasLayer/HighscorePanel/VBoxContainer/GridContainer/Points5Label
@onready var name_6_label = $CanvasLayer/HighscorePanel/VBoxContainer/GridContainer/Name6Label
@onready var points_6_label = $CanvasLayer/HighscorePanel/VBoxContainer/GridContainer/Points6Label
@onready var name_7_label = $CanvasLayer/HighscorePanel/VBoxContainer/GridContainer/Name7Label
@onready var points_7_label = $CanvasLayer/HighscorePanel/VBoxContainer/GridContainer/Points7Label
@onready var name_8_label = $CanvasLayer/HighscorePanel/VBoxContainer/GridContainer/Name8Label
@onready var points_8_label = $CanvasLayer/HighscorePanel/VBoxContainer/GridContainer/Points8Label
@onready var name_9_label = $CanvasLayer/HighscorePanel/VBoxContainer/GridContainer/Name9Label
@onready var points_9_label = $CanvasLayer/HighscorePanel/VBoxContainer/GridContainer/Points9Label
@onready var name_10_label = $CanvasLayer/HighscorePanel/VBoxContainer/GridContainer/Name10Label
@onready var points_10_label = $CanvasLayer/HighscorePanel/VBoxContainer/GridContainer/Points10Label

var names = []
var points = []

# SaveLoad
var m_Password = "R4nd0m_p455w0Rd"
var m_GameStateFile = "user://breakout.dat"       # File path to the saved game state


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	SaveLoadHighscores.Initialize(m_GameStateFile, m_Password)
	open_save_game()
	names = [name_1_label, name_2_label, name_3_label, name_4_label, name_5_label, name_6_label, name_7_label, name_8_label, name_9_label, name_10_label]
	points = [points_1_label, points_2_label, points_3_label, points_4_label, points_5_label, points_6_label, points_7_label, points_8_label, points_9_label, points_10_label]
	$CanvasLayer/Panel3/VBoxContainer/PlayerNameLineEdit.text = highscore.last_player


func open_save_game():
	var status = SaveLoadHighscores.OpenFile(FileAccess.READ)		# Open the file with READ access
	if status != OK:
		highscore = Highscores.new(10)
		highscore.last_player = "PlayerName"
		print("Unable to open the file %s. Received error: %d" % [m_GameStateFile, status])
	else:
		highscore = Highscores.new(10)
		SaveLoadHighscores.Deserialize(highscore)
		SaveLoadHighscores.CloseFile()


func write_save_game():
	var status = SaveLoadHighscores.OpenFile(FileAccess.WRITE)
	if status != OK:
		print("Unable to open the file %s. Received error: %d" % [m_GameStateFile, status])
		return
	SaveLoadHighscores.Serialize(highscore)
	SaveLoadHighscores.CloseFile()


func _exit_tree():
	write_save_game()
	SaveLoadHighscores.Clear()


func build_highscore_list():
	var i = 0
	for entry in highscore.list:
		if !entry.is_empty():
			var dict = entry
			for key in dict:
				var value = dict[key]
				names[i].text = key
				points[i].text = str(value)
				names[i].visible = true
				points[i].visible = true
		else:
			#print(names[i])
			names[i].visible = false
			points[i].visible = false
		i += 1


func _on_highscore_button_pressed():
	build_highscore_list()
	$CanvasLayer/HighscorePanel.visible = true


func _on_random_points_button_pressed():
	var points = randi_range(1000, 15000)
	$CanvasLayer/Panel3/VBoxContainer/NewPointsLabel.text = str(points)
	if highscore.test_points(points):
		$CanvasLayer/Panel3/VBoxContainer/SubmitButton.disabled = false
	else:
		$CanvasLayer/Panel3/VBoxContainer/SubmitButton.disabled = true


func _on_back_button_pressed():
	$CanvasLayer/HighscorePanel.visible = false


func _on_submit_button_pressed():
	var player = $CanvasLayer/Panel3/VBoxContainer/PlayerNameLineEdit.text
	var point = int($CanvasLayer/Panel3/VBoxContainer/NewPointsLabel.text)
	highscore.add_entry(player, point)
	highscore.show_entries()
	build_highscore_list()
	highscore.last_player = str(player)
