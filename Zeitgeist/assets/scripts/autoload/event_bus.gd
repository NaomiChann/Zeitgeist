extends Node

signal OnLoadzoneTriggered()
signal OnRoomLoaded()

signal ContinuityStored()
signal SpawnPlayer( spawn_point : Vector2 )

signal Resume( status : bool )
signal TransitionScreen( type : String, mode : String )

signal UpdateDisplayMap( new_coordinate : Vector2 )
signal UpdateDisplayHealth( health_current : int, increase : bool )

signal ItemPickup( pickup_type : utils.Pickup, pickup_value : utils.Upgrade )

signal BossDead()
