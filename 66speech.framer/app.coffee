# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Tony"
	twitter: ""
	description: ""


{SpeechSynth} = require "SpeechSynth"

narrator = new SpeechSynth 
	volume: 1, rate: 0.9, pitch: 1, voice: "Daniel"

joke = new Layer
	size: Screen.width*0.9, backgroundColor: null, x: Align.center
	html: "Chuck Norris Facts", maxY: Screen.height
	style: textAlign: "center", fontSize: "2.5rem", lineHeight: "4rem"

button = new Layer
	width: Screen.width/2.2, x: Align.center, y: Align.center(-300), borderRadius: 10
	height: Screen.height/13, backgroundColor: Color.random().darken(20)
	html: "Give Me"
	style: textAlign: "center", lineHeight: "7rem", fontSize: "2.2rem"

button.onClick ->
	Utils.domLoadJSON "http://api.icndb.com/jokes/random?limitTo=[nerdy]",(err, response) ->
		if response.type is "success"
			narrator.text = response.value.joke
		else 
			narrator.text = 
				"If you're hearing this, then the proper response did not load."
		narrator.speak()
		
		joke.html = response.value.joke
		Utils.delay 2.2, ->
			button.html = "Give me another"