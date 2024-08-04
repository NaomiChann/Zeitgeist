extends Node

signal OnLoadzoneTriggered( transition_type : String )
signal SpawnPlayer( spawn_point : Vector2 )

signal TransitionScreen( type : String, mode : String )
signal TransitionFinished()

signal UpdateMapDisplay( new_coordinate : Vector2 )
