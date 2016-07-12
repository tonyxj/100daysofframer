
# Based on Marc Kren's demo (http://share.framerjs.com/68inpw0r5taw/)

# Marc's original comments: Load Josh's modified OrientationEvents module
acc = require "OrientationEvents"
acc.OrientationEvents()


# Variables ------------------------------------------

updateInterval = .2
acc.smoothOrientation = .5

roll = null
landscapeThreshold = -50
currentOrientation = "portrait"


# Orientation -------------------------------------

#Orientation handling

#Framer.Loop.on "render", -> # Fastest method but this introduces artefacts
Utils.interval updateInterval, ->
	roll = acc.orientation.gamma if acc.orientation?

	if roll < landscapeThreshold

		for layer in Framer.CurrentContext.layers # rotate all layers counter-clockwise
			layer.rotation += 90 if currentOrientation is "portrait"

		switchedToLandscape() if currentOrientation is "portrait"
		currentOrientation = "landscape"

	else if roll isnt null
		Framer.Device.setOrientation(0, true)

		for layer in Framer.CurrentContext.layers # rotate all layers clockwise 
			layer.rotation -= 90 if currentOrientation is "landscape"

		switchedToPortrait() if currentOrientation is "landscape"
		currentOrientation = "portrait"



switchedToLandscape = ->
# 	print "currentOrientation: #{currentOrientation}"
	# do other stuff
	header.props =
		width: 1334
		y: 570
		x: 0
		height: newHeaderH
		style:
			fontSize: "60px"
			lineHeight: "200px"
			
	moreButton.props =
		x: 570 - newScreenW/3 * 2
		y: newScreenW/3 * 2
	
	for i in [1 .. 5]
		Framer["card#{i}"].props =
			x: 570 - newScreenW/3 
			size: newScreenW/3
			y: 0
		if i % 3 == 0
			Framer["card#{i}"].y =  newScreenW/3 * 2
		if i % 3 == 2
			Framer["card#{i}"].y = newScreenW/3
		if i >= 4 and i < 7
			Framer["card#{i}"].x = 570 - newScreenW/3 * 2



switchedToPortrait = ->
# 	print "currentOrientation: #{currentOrientation}"
	# do other stuff
	moreButton.props =
		size: initialScreenW/2
		x: initialScreenW/2
		y: initialScreenW + headerH
	header.props =	
		width: 750
		height: headerH
		y: 0
		style:
			fontSize: "70px"
			lineHeight: "280px"
	for i in [1 .. 5]
		Framer["card#{i}"].props = 
			size: initialScreenW/2
		if i % 2 == 1
			Framer["card#{i}"].x = 0
		if i % 2 == 0
			Framer["card#{i}"].x = initialScreenW/2
		if i < 3
			Framer["card#{i}"].y = 0 + headerH
		if i >= 3 and i < 5
			Framer["card#{i}"].y = initialScreenW / 2 + headerH
		if i >= 5
			Framer["card#{i}"].y = initialScreenW + headerH


bg = new BackgroundLayer
	backgroundColor: "black"

headerH = 300
newHeaderH = 200
initialScreenW = 750
newScreenW = 1334

header = new Layer
	width: Screen.width
	height: headerH
	backgroundColor: "#ff9049"
	html: "Artist: "
	style:
		fontSize: "70px"
		lineHeight: "280px"
		fontWeight: 300
		paddingLeft: "3rem"

moreButton = new Layer
	backgroundColor: "black"
	size: initialScreenW/2
	x: initialScreenW/2
	y: initialScreenW + headerH
	html: "MORE ALBUMS"
	style:
		lineHeight: "300px"
		fontSize: "2.1rem"
		verticalAlign: "middle"
		textAlign: "center"
		fontWeight: 300
		letterSpacing: "2px"
	

for i in [1 .. 5]
	Framer["card#{i}"] = new Layer
		name: "card#{i}"
		size: initialScreenW/2
	if i % 2 == 0
		Framer["card#{i}"].x = initialScreenW/2
	if i < 3
		Framer["card#{i}"].y = 0 + headerH
	if i >= 3 and i < 5
		Framer["card#{i}"].y = initialScreenW / 2 + headerH
	if i >= 5
		Framer["card#{i}"].y = initialScreenW + headerH


# Solution: use the 'https://crossorigin.me/' prefix
Utils.domLoadJSON "https://crossorigin.me/https://itunes.apple.com/lookup?amgArtistId=468749,5723&entity=album&limit=5", (error, response) ->
# 	print response
	# load cover from results
	for i in [1 .. 5] 
		Framer["card#{i}"].image = response.results[i].artworkUrl100
	
	header.html += response.results[0].artistName


