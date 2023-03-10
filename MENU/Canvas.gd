extends CanvasLayer

#SIGNAL-------------------------------------------------------------------------
signal start_game
# FONCTION PRINCIPALE DE DEPART-------------------------------------------------
func _ready():
	pass

func _process(delta):
	pass

#MISE A JOUR ET AFFICHAGE DU SCORE----------------------------------------------
func update_score(value) :
	$MarginContainer/ScoreLabel.text = str(value)
	
#MISE A JOUR ET AFFICHAGE DU TEMPS----------------------------------------------
func update_timer (value) :
	$MarginContainer/TimeLabel.text = str(value)
	
#AFFICHAGE ET DISPARITION DU MESSAGE--------------------------------------------
func showmessage(text) :
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
	
#TIMER DU MESSAGE---------------------------------------------------------------
func _on_MessageTimer_timeout():
	$MessageLabel.hide()
	
#BOUTON START-------------------------------------------------------------------
func _on_StartButton_pressed():
	$StartButton.hide()
	$MessageLabel.hide()
	emit_signal("start_game")
#FONCTION GAME OVER-------------------------------------------------------------
func show_game_over():
	showmessage("Game Over")
	yield($MessageTimer,"timeout")
	$StartButton.show()
	$MessageLabel.text = "COIN DASH !!"
	$MessageLabel.show()

