extends NinePatchRect

export var text_index:int = 0

var text_placeholder := "Texto"
var text_one := "Welcome to Anything Growths.\nThe game where you can “growth” \ndifferent things to achieve the goal\nof reaching the next room.\nWhen you hover the mouse over something\nthe red marker tells you if it can grow. \nThe EXIT marks, well, the exit.You can always restart the level with the\nbutton or “R” key.\nWhenever you make something grow it\nmakes some physical property change.\nThis spring give you more impulse when\ngets bigger"
var text_two := "When enemies get bigger they become slower.\nIn opposition when you make anything grow, you shrink. \nThat makes you smaller, faster, but you jump less\nYour jump is variable. As more you press the jump\nkey, Space, you go higher. \n"
var text_three := "Tambien vas a encontrar PowerUps para ayudarte.\nPor ejemplo 'salto' te va a dar la habilidad de realizar un doble salto.\nPero mucho cuidado, las habilidades solo impactaran en el Schodi que las consuma, no en ambos."
var text_four := "'Dash' te va a dar la habilidad de realizar un Dash.\nOtra vez no olvides que la habilidad solo sera adquirida por el Schodi que la consuma.\nElige sabiamente tu observacion.\nPuedes dashear con SHIFT"
var text_five := "'WallJ' te va a dar la habilidad de realizar saltos contra la pared --> Wall Jumps.\nEl Wall Jump es muy poderoso y te permite impulsarte hacia arriba casi indefinidamente, solo tienes que intentar seguir presionado a la pared de la cual te expulsas."
var text_six := "Si consumes mas de un PowerUp las habilidades se combinan.\nPero piensa muy bien antes de hacerlo, a veces alterar tanto el movimiento de un Schodi puede confudirte en escenarios complejos..."
var text_seven := "Una vez por nivel puedes echar un vistazo por un agujero en la parte no observable.\nSon 3 solidos segundos, no los desaproveches.\nAh... no puedes moverte mientras echas ese vistazo... though life.\nPresiona 'TAB' para mirar, la zona no observable se volvera observable esos segundos."
var text_eight := "Tomate todo el tiempo necesario para observar los escenarios.\nUtiliza todas las referencias posibles pero no confies ciegamente en ellas.\nUn game designer sadico puede haberlas elaborado para hacerte perder la cabeza.\nEl mismo game designer sadico puede haber creado escenarios imposibles. Observa muy bien ya que identificar eso puede ser una gran pista para decidir la observacion.\nNo olvides que el Schodi no observable SOLO DEBE SOBREVIVIR, no importa el lugar donde finalice"

var texts := [
	text_placeholder,
	text_one,
	text_two,
	text_three,
	text_four,
	text_five,
	text_six,
	text_seven,
	text_eight
]

func _ready() -> void:
	$Label.text = texts[text_index]
#	if text_to_show == "text_one":
#		$Label.text = text_one
#	elif text_to_show == "text_two":
#		$Label.text = text_two
#	elif text_to_show == "text_three":
#		$Label.text = text_three
	
	get_tree().paused = true


func _on_Button_pressed() -> void:
	get_tree().paused = false
	queue_free()
