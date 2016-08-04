
# PAGE
class Room
	constructor: ->
		@pages = []
		@currentPage = 0
		@interval = null
		
		background = new BackgroundLayer backgroundColor: "#fff"
		
		@pageComponent = new PageComponent
			name: "roomPageComponent"
			width: Screen.width
			height: Screen.height * 0.81
			scrollVertical: false
		
		@pageComponent.animationOptions = curve: "spring(100, 20, 0)"
		@pageComponent.content.draggable.overdrag = false
		@pageComponent.content.index = 2
		
		bgBlock = new Layer
			width: Screen.width
			height: Screen.height
			backgroundColor: "rgba(0,0,0,0.65)"
			parent: @pageComponent
		bgBlock.sendToBack()
		
		bgImg = new Layer
			width: Screen.width * 2
			height: Screen.height * 0.81
			x: -Screen.width / 3.8
			parent: @pageComponent
			image: "images/bgimg.png"
		bgImg.sendToBack()
		
		logo = new Layer
			width: Screen.width * 0.63
			height: 105
			x: Align.center
			y: Screen.height * 0.31
			image: "images/logo.png"
		
		nextButton = new Layer
			name: "nextButton"
			maxY: Screen.height
			width: Screen.width, height: 138
			backgroundColor: Utils.randomColor().darken(20)
		
		#Events
		nextButton.on Events.Click, =>
			@autoPlay false
			@_animateToNextPage()
			@autoPlay true
		
		@pageComponent.on "change:currentPage", =>
			@currentPage = 
				@pageComponent.horizontalPageIndex(@pageComponent.currentPage)
				
			for page in @pages
				page.progressActive.animate
					properties: opacity: 0
					curve: "ease"
					time: 0.3
					
			@pages[@currentPage].progressActive.animate
				properties: opacity: 1
				curve: "ease"
				time: 0.3
				
		@pageComponent.content.onDragStart => @autoPlay false
		@pageComponent.content.onDragEnd => @autoPlay true
			
		@pageComponent.onMove =>
			bgImg.x = Utils.modulate(@pageComponent.scrollX
				[0, @pageComponent.width * (@pages.length + 1)]
				[-Screen.width / 3.8, -Screen.width]
				true
			) 
			
			logo.y = Utils.modulate(@pageComponent.scrollX
				[0, 750]
				[Screen.height * 0.31, 60]
				true
			) 
			
			logo.scale = Utils.modulate(@pageComponent.scrollX
				[0, 750]
				[1, 0.4]
				true
			) 
			
			logo.opacity = Utils.modulate(@pageComponent.scrollX
				[0, 450]
				[1, 0.7]
				true
			) 
			
			for page, index in @pages
				
				currentCardXPos = page.cardArea.screenFrame.x
				
				page.card.scale = Utils.modulate(currentCardXPos
					[room.pageComponent.width, -room.pageComponent.width]
					[1.5, 0.5]
					true
				)
				
				page.card.opacity = Utils.modulate(currentCardXPos
					[0, -room.pageComponent.width]
					[1, 0]
					true
				)
				
			
				if page.cardArea.screenFrame.x < 0
					page.text.opacity = Utils.modulate(currentCardXPos
						[0, -room.pageComponent.width]
						[1, 0]
						true
					)
				else if page.cardArea.screenFrame.x > 0
					page.text.opacity = Utils.modulate(currentCardXPos
						[room.pageComponent.width, 0]
						[0, 1]
						true
					)
	
	createPage: (config, index) ->
		page = new Page @, config, index
	
	autoPlay: (flag) =>
		if flag
			@interval = Utils.interval 6, @_animateToNextPage 
		else clearInterval @interval
			
	_animateToNextPage: =>
		lastPage = @pages.length - 1
		nextPage = 
			if @currentPage isnt lastPage
				@pages[@currentPage + 1].cardArea 
			else @pages[0].cardArea
		
		@pageComponent.snapToPage nextPage, true, animationOptions = 
			curve: "spring(100, 20, 0)"

class Page
	constructor: (room, name, index) ->
		
		initialPageVisibility = if index is 0 then 1 else 0
		
		@cardArea = new Layer
			name: "cardArea#{index}_#{name}"
			x: room.pageComponent.height * index
			size: room.pageComponent.size
			backgroundColor: null
			superLayer: room.pageComponent.content
			index: 3

		@card = new Layer
			name: "card#{index}_#{name}"
			y: Screen.height* 0.22
			width: Screen.width * 0.92
			height: Screen.height * 0.32
			image: "images/photo#{index+1}.png"
			superLayer: @cardArea
			
		@card.centerX()
		@card.pixelAlign()
		
		progressProps =
			name: "progressDot#{index}"
			x: Screen.width/2.2 + (index * 20)
			y: Screen.height * 0.755
			size: 9
			borderRadius: "50%"
		
		progressDots = new Layer progressProps
		progressDots.backgroundColor = "#000"

		@progressActive = new Layer progressProps
		@progressActive.name = "progressActive"
		@progressActive.backgroundColor = "white"
		@progressActive.opacity = initialPageVisibility
			
		@text = new Layer
			name: "text#{index+1}_#{name}"
			image: "images/text#{index+1}.png" 
			x: Align.center
			y: Screen.height * 0.6
			width: Screen.width, height: Screen.height/6.8
			opacity: initialPageVisibility
		
		room.pages.push @

# Layers
configs = ["landing", "home", "community", "perks", "start"]

room = new Room
room.createPage config, index for config, index in configs
room.autoPlay(true)

buttons = new Layer
	image: "images/buttons.png"
	width: Screen.width
	height: 260
	y: Screen.height - 260
