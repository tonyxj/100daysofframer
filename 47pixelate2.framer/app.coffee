# Framer Impressionist
# 	Tony Jing
# A rebound of Henrique Gusso's Framer Pixelation Project
# 	http://dribbble.com/shots/2721050-Framer-Pixelation

# Setup image
image = "images/#{Utils.randomChoice([3,4])}.jpg"

# Create some fancy colors for button
buttonColorPairs = []
delayTime = 5

gradientsJSON = JSON.parse Utils.domLoadDataSync "https://raw.githubusercontent.com/Ghosh/uiGradients/master/gradients.json"

for color in gradientsJSON
	buttonColorPairs.push(color.colors.join(","))

# Createb base image
imageSource = new Image()
imageSource.src = image

# Create container for image
imageContainer = new Layer
	backgroundColor: ''
	frame: Screen.frame

timer = new Layer
	html: "How would Monet do it?"
	height: 50
	width: 300
	x: Align.center
	y: 50
	backgroundColor: "0256ec"
	borderRadius: 5
	style: 
		background: "linear-gradient(to bottom right, #{Utils.randomChoice(buttonColorPairs)})"
		textAlign: "center"
		lineHeight: "3.2rem"
		fontSize: "1.2rem"
		fontWeight: 300
		

# Click to blobify
timer.onClick ->
	timerCount = delayTime
	timer.html = timerCount
	Utils.interval 1, ->
		timerCount -= 1
		timer.html = timerCount 
	Utils.delay delayTime + 1, ->
		timer.opacity = 0
	blobify()
	
# Blobification
blobify = ->
	# Setting the image height 
	imageHeight = Screen.height * .6
	
	# Set an arbitray blob size
	blobSize =  Screen.height / 40
	
	# Define the number of blobs vertically and horizontally
	numBlobsVer = Math.round(imageHeight / blobSize)
	numBlobsHor  = Math.round(numBlobsVer / (imageSource.height / imageSource.width))
	
	# Draw canvas and get color data
	canvas = document.createElement('canvas')
	ctx = canvas.getContext('2d')
	ctx.drawImage(imageSource, 0, 0, numBlobsHor, numBlobsVer)
	color = ctx.getImageData(0,0,numBlobsHor,numBlobsVer).data

	imageDisplay = new Layer
		parent: imageContainer
		backgroundColor: ''
		image: image
		width: blobSize * numBlobsHor
		height: blobSize * numBlobsVer
	imageDisplay.center()
	
	blobContainer = new Layer
		width: blobSize * numBlobsHor
		height: blobSize * numBlobsVer
		backgroundColor: null
		x: Align.center
		y: Align.center
	
	# Set the original iterating number for the index in Colors
	i = 0
	
	Utils.delay delayTime, ->
		for h in [0...numBlobsVer]
			for w in [0...numBlobsHor]
				do ->
					originalColor = new Color("rgb(#{color[i]}, #{color[i+1]}, #{color[i+2]})")
					bgColor = originalColor.saturate(18)
					
					# Draw blob
					blob = new Layer
						parent: blobContainer
						size: blobSize
						x: (w) * blobSize
						y: (h) * blobSize
						scale: 0
						opacity: 0
						borderRadius: "#{Utils.randomNumber(0,50)}%"
						blur: Utils.randomNumber(2.2,5)
						style:
							backgroundColor: "#{bgColor}"
							mixBlendMode: "color"
					
					# Show blob
					Utils.delay .7, ->
						blob.animate
							properties: 
								scale: Utils.randomNumber(1.1,2.4)
								opacity: 1
							time: Utils.randomNumber(0, .7)
						
					# Iterate i for the next blob's colors
					i += 4
					
		# Hide the background image on click
		imageDisplay.animate 
			properties: 
				opacity: 0