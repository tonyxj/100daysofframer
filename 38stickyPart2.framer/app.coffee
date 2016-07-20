# Sticky header part 2
Screen.backgroundColor = "#fff"
scroll = new ScrollComponent
	size: Screen.size
	scrollHorizontal: false

# Split creates an array out of a string
alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("")
headers = []
headerHeight = 80
sectionHeight = 800
sectionHeightWithoutHeader = 720
numOfDividers = 5

for i in [0 ... alphabet.length]
	header = new Layer
		width: Screen.width - 64
		x: 32
		height: headerHeight
		backgroundColor: "#efefef"
		parent: scroll.content
		y: i * sectionHeight
		html: alphabet[i]
		color: "#0275EE"
		style: 
			fontSize: "2.3rem"
			lineHeight: "5rem"
			paddingLeft: "1.5rem"
	headers.push header
	# Storing the original y value on the fly inside header element
	header.originalYPos = header.y
		
	for j in [0...numOfDividers]
		line = new Layer
			width: header.width
			height: sectionHeightWithoutHeader / (numOfDividers + 1)
			x: 32
			# Nested loops, both j and i are used
			y: (sectionHeightWithoutHeader / (numOfDividers + 1) * j + 75) + (i * sectionHeight)
			backgroundColor: null
			superLayer: scroll.content
			style: borderBottom: "1px solid lightgray"

for header in headers
	header.bringToFront()
	
scroll.onMove ->
	scrAmt = scroll.scrollY
	for header in headers
		if scrAmt > header.originalYPos
			if scrAmt < header.originalYPos + sectionHeightWithoutHeader
				header.y = scrAmt
			else 
				header.y = header.originalYPos + sectionHeightWithoutHeader 
		else
			header.y = header.originalYPos
			
			
			
			
			