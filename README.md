# TestHighscore
 A GDScript class to be used as highscore listing in games.

## highscores.gd 
Class that contains everything to create a highscore listing. Contains Serialize/Deserialize methods.

## game.gd
Contains a Node2D with a CanvasLayer to show the use of highscores.gd including saving (autosave when application is closed) and loading when the application starts. Also shows an example highscore list with ten entries and a form to generate random points and a line edit to change the player's name. Player name is stored in highscores.gd as well and loaded when the application is started.

## save_load_highscores.gd
Taken from https://www.nightquestgames.com/godot-4-save-and-load-games-how-to-build-a-robust-system/
Implemented as a singleton in autoload.

