extends Area2D
#SIGNAUX------------------------------------------------------------------------
signal pickup
signal hurt
#VARIABLE-----------------------------------------------------------------------
export (int) var speed
var velocity = Vector2()
var screensize = Vector2(480,720)


func _ready():
	pass 

func _process(delta):
	get_input() # appel fonction des mouvements
	position += velocity * delta
	position.x = clamp(position.x,10,screensize.x-10)
	position.y = clamp(position.y,10,screensize.y-15)
	
	
#FONCTION DES MOUVEMENTS DU JOUEURS---------------------------------------------
func get_input():
	velocity =Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x -=1
	if Input.is_action_pressed("ui_right"):
		velocity.x +=1
	if Input.is_action_pressed("ui_up"):
		velocity.y -=1
	if Input.is_action_pressed("ui_down"):
		velocity.y +=1
	if velocity.length() > 0 :
		velocity = velocity.normalized() * speed
		$AnimatedSprite.animation="run"
		$AnimatedSprite.flip_h = velocity.x < 0
	else :
		$AnimatedSprite.animation = "idle"		
#-------------------------------------------------------------------------------

#FONCTION START-----------------------------------------------------------------
func start(pos):
	set_process(true)
	position = pos
	$AnimatedSprite.animation = "idle"
#-------------------------------------------------------------------------------

#FONCTION DIE-------------------------------------------------------------------
func die():
	$AnimatedSprite.animation = "hurt"
	set_process(false)
#-------------------------------------------------------------------------------
	
#FONCTION COLLISION-------------------------------------------------------------
func _on_Player_area_entered(area):
	if area.is_in_group("COINS") :
		area.pickup()
		emit_signal("pickup")
	if area.is_in_group("OBSTACLES") :
		emit_signal("hurt")
		die()
#-------------------------------------------------------------------------------
