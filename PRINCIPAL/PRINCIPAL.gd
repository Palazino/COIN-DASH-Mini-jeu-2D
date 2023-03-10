extends Node2D
#VARIABLE EXPORTEE
export (PackedScene) var coin
export (int) var playtime
#VARIABLE
var level
var score
var Time_Left
var screensize
var playing = false

func _ready():
	randomize()
	screensize = get_viewport().get_visible_rect().size
	$Player.screensize = screensize
	$Player.hide()

func new_game():
	playing =true
	level = 1
	score = 0
	Time_Left = playtime
	$Player.start($PlayerStart.position)
	$Player.show()
	$GameTimer.start()
	spawn_coins()
	$CanvasLayer.update_score(score)
	$CanvasLayer.update_timer(Time_Left)
	
func spawn_coins():
	
	for i in range ( 4 + level) :
		var c  = coin.instance()
		$CoinContainer.add_child(c)
		c.screensize = screensize
		c.position = Vector2(rand_range(0,screensize.x),rand_range(0,screensize.y))
		
func _process(delta):
	if playing and $CoinContainer.get_child_count() == 0 :
		level +=1
		Time_Left +=5
		spawn_coins()

func _on_GameTimer_timeout():
	Time_Left -= 1
	$CanvasLayer.update_timer(Time_Left)
	if Time_Left <= 0:
		game_over()
		
func game_over():
	playing = false
	$GameTimer.stop()
	for coin in $CoinContainer.get_children():
		coin.queue_free()
	$CanvasLayer.show_game_over()
	$Player.die()
	
func _on_Player_pickup():
	score += 1
	$CanvasLayer.update_score(score)
	
func _on_Player_hurt():
	game_over()
	
func _on_CanvasLayer_start_game():
	new_game()
