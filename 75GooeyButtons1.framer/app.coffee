
contrastContainer = new Layer
	size: Screen.size
	backgroundColor: "#000"
	contrast: 4000

mainButton = new Layer
	size: 200
	maxX: Screen.width - 60
	maxY: Screen.height - 80
	borderRadius: "50%"
	backgroundColor: "crimson"
	blur: 20
	parent: contrastContainer

subButtonsArray = []
for i in [0..2]
	subButton = new Layer
		parent: contrastContainer
	subButton.props = mainButton.props
	subButton.states.add 
		clicked:
			maxY: Screen.height - 80 - (i+1) * (mainButton.width + 50)
	subButton.states.animationOptions = curve: "spring(115,12,0)"
	subButtonsArray.push(subButton)

mainButton.onClick ->
	for layer in subButtonsArray
		layer.states.next()

