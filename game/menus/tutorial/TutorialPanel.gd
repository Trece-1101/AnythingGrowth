extends NinePatchRect

export var text_index:int = 0

var text_placeholder := "Texto"
var text_one := "Welcome to Anything Growths.\nThe game where you can “growth” \ndifferent things to achieve the goal\nof reaching the next room.\nWhen you hover the mouse over something\nthe red marker tells you if it can grow. \nThe EXIT marks, well, the exit.You can always restart the level with the\nbutton or “R” key.\nWhenever you make something grow it\nmakes some physical property change.\nThis spring give you more impulse when\ngets bigger"
var text_two := "When enemies get bigger they become slower.\nIn opposition when you make anything grow, you shrink. \nThat makes you smaller, faster, but you jump less\nYour jump is variable. As more you press the jump\nkey, Space, you go higher.\n"
var text_three := "Enemies can collide with each other. \nUse this to your advantage, make one\nor both grow until they collide and that\nwill give you an open path.\nBeware, all things can grow until 5 times,\nindividually. But you can only use 6 'growth' per level.\nYou CAN’T undo, choose wisely"
var text_four := "You have a time limit for each level.\nIf you don’t reach the EXIT when the \nclock hits 0 the level restart.\nWhen you grow a platform not only his\nsize gets bigger, also the load it can hold.\nThat will be relevant later.\nGet smaller so you can fit\nunder the blocks"
var text_five := "You can dash, with SHIFT or CAPS LOCK,\nthe dash became shorter when you are smaller,\nbut is a powerful tool, you can dash even on air. You can also make a little\nextra jump if you release the jump key when falling.\nDo you remember the platform load? Make the ball bigger until the platform can’t hold it."
var text_six := "Those are the basics. These are all the elements you can make growth. This isn't an action platformer, take your time, sometimes less obvious solutions are the best way to go.\nAfter this tutorial level you start the real game"

var texts := [
	text_placeholder,
	text_one,
	text_two,
	text_three,
	text_four,
	text_five,
	text_six
]

func _ready() -> void:
	$Label.text = texts[text_index]
	get_tree().paused = true


func _on_Button_pressed() -> void:
	GameMusic.play_button()
	get_tree().paused = false
	queue_free()
