extends CanvasLayer


# TODO : les infos live des joueurs doivent etre dispo dans Global !
onready var g = $"/root/Global"

# Get les text dans le CanvasLayer (Le seul truc a ne pas changer !!)
# !!! les noms ne doivent pas changer dans l'editeur !
# TODO access direct avec le $ ??
onready var moving_points_text = $MovePointsColorRect/MovingPoints
onready var moving_points_max_text = $MovePointsColorRect/MovingPointsMax
onready var timer_counter_text = $TimerColorRect/TimeCounter
onready var gold_count_text = $GoldColorRect/GoldCount


func _ready():
	# TODO verifie que les scores sont a 0 ??
	pass

var gold: int = 1
# TODO utiliser des signaux pour moins de render ??
func _process(delta):
	# TODO if le state du jeu n'est pas "pause" ou autre ?
	# pdate_timer(g.decont, delta) 
	# TODO if le score gold a change:
	# update_gold_score(g.player.gold_score)
	# TODO if les move points on change:
	# update_gold_score(g.player.gold_score)
	
	# TEST
	gold = 1 + gold
	print(gold)
	update_gold_score(gold)
	


func update_gold_score(new_score: int):
	print (new_score)
	gold_count_text.text = str(new_score)
	# TODO animation ? # bourse / tas d'or qui monte ?


func update_move_points(new_points: int,  new_max: int):
	moving_points_text.text = str(new_points)
	moving_points_max_text.text = str(new_max)
	# TODO animation ?
	# scale le text s'il passe ne dizaine (s'il ne prend plus la meme place)

func update_timer(new_decount: int, _delta: float):
	# TODO int ou float ?? (Quentin prefere int)
	timer_counter_text.text = str(new_decount)
