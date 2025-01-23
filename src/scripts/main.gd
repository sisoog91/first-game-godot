extends Node

@export var mob_scene = load("res://src/scenes/mob.tscn")
var score


func _ready():
	new_game()
	
# Lo que ocurre cuando el Player es tocado por el Mob enemigo
func game_over():
	$ScoreTimer.stop() # Se para el timer de puntuación
	$MobTimer.stop() # y el timer de los enemigos

# Lo que ocurre cuando se reinicia el juego
func new_game():
	score = 0 # Los puntos vuelven a 0
	$Player.start($StartPosition.position) # El jugador vuelve a su posición inicial
	$StartTimer.start() # El temporizador vuelve a comenzar


func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI / 2
	mob.position = mob_spawn_location.position
	
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
func _on_score_timer_timeout() -> void:
	score += 1

func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
