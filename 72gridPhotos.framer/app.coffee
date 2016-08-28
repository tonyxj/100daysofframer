# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Tony"
	twitter: ""
	description: ""


bg = new BackgroundLayer 
	backgroundColor: "#dedede"
	
Framer.Defaults.Animation = curve: "spring(220, 23, 13)"
scroll = new ScrollComponent
	size: Screen
	backgroundColor: null
	scrollHorizontal: false

bgCover = new Layer
	width: Screen.width
	backgroundColor: "#dedede"
	parent: scroll.content
	opacity: 0
bgCover.states.add hide: opacity: 0.97
bgCover.states.animationOptions = time: 0.35
	
ignoreAllExcept = (current)->
	for layer in scroll.content.subLayers
		layer.ignoreEvents = true
	current.ignoreEvents = false

resumeAll = ->
	for layer in scroll.content.subLayers
		if layer.name is "card"
			layer.ignoreEvents = false

class Card extends Layer
	constructor: (options={}) ->
# 		@_width = options.width
		@_margin = options.margin
		@_y = options.y
		super options
		@props = 
			y: @_y
			name: "card"
			height: Math.round(Utils.randomNumber(Screen.height*0.3, Screen.height*0.6))
			borderRadius: 6
			backgroundColor: "#fefefe"
			shadowY: 5
			shadowBlur: 30
			shadowColor: "rgba(0,0,0,0.15)"

		oX = @x
		oY = 0
		oW = @width
		oH = @height
		alreadyOpen = false
		
		@onClick ->
			bgCover.bringToFront()
			@bringToFront()
			imageWidth =  Screen.width - @_margin * 4
			imageScaleRatio = imageWidth / @.subLayers[0].width
			imageHeight = imageScaleRatio * @subLayers[0].height
			@.states.add
				on: 
					width: Screen.width - @_margin * 2
					x: @_margin
					y: scroll.scrollY + @_margin
					height: imageHeight + @_margin * 2 + @subLayers[1].height
			thumb = @subLayers[0]
			@subLayers[0].states.add
				on: 
					width: imageWidth
					height: imageHeight
			@subLayers[1].states.add
				on: 
					y: thumb.maxY * imageScaleRatio
				
			if alreadyOpen is false
				oY = @screenFrame.y
				@states.switch("on")
				@subLayers[0].states.switch("on")
				@subLayers[1].states.switch("on")
				bgCover.animate 
					properties: opacity: 0.97
					time: 0.35
				scroll.scrollVertical = false
				ignoreAllExcept(@)
				alreadyOpen = true
			else	
				@.states.add
					regular:
						width: oW
						height: oH
						y: oY + scroll.scrollY
						x: oX
				@states.switch("regular")
				@subLayers[0].states.switch("default")
				@subLayers[1].states.switch("default")
				bgCover.animate
					properties: opacity: 0
					time: 0.35
				resumeAll()
				scroll.scrollVertical = true
				alreadyOpen = false
				

createLayout = (column, totalCards, margin) ->
	scroll.contentInset =
		bottom: margin
	
	textMargin = 5
	textH = 12
	profileH = 80
	textBg = new Color("#dcdede")
	cardWidth = (Screen.width-margin*column-margin)/column
	
	for i in [0...column]
	
		Framer["cards#{i}"] = []
		
		for j in [0...Math.round(totalCards/column)]
			card = new Card
				width: cardWidth
				x: margin + i * (cardWidth + margin)
				margin: margin
				
			Framer["cards#{i}"].push(card)
			
		for layer, t in Framer["cards#{i}"]
			if t > 0
				layer.y = (Framer["cards#{i}"][t-1].height + Framer["cards#{i}"][t-1].y + margin)
			else
				layer.y = margin
				
			layer.parent = scroll.content
			
			thumbnail = new Layer
				width: cardWidth - margin*2
				height: Utils.randomNumber(layer.height*0.5, layer.height - 140)
				x: margin
				y: margin
				parent: layer
				borderRadius: 5
				image: Utils.randomImage()
			
			layerCopy = new Layer
				width: layer.width
				backgroundColor: null
				parent: layer
				y: thumbnail.maxY + margin
			
			num = (layer.height - thumbnail.height - margin * 2 - profileH) / (textH + textMargin)
			factor = 0
			for k in [0...num]
				if (k * (textH + textMargin) + thumbnail.maxY + margin) < (layer.height - profileH - margin*2)
					factor = k
					textLine = new Layer
						parent: layerCopy
						width: thumbnail.width - margin * 2
						x: Align.center
						backgroundColor: textBg
						y: k * (textH + textMargin)
						height: textH
			profile = new Layer 
				size: profileH - margin
				borderRadius: "50%"
				parent: layerCopy
				x: margin *2
				backgroundColor: textBg.darken(20)
				y: factor * (textH + textMargin) + margin * 2
			if factor is 0
				profile.y = margin
			layerCopy.height = factor * (textH + textMargin) + margin * 4 + profileH
			
			for l in [0...2]
				profileText = new Layer
					parent: layerCopy
					x: profile.maxX + margin
					width: thumbnail.width - margin * 2 - profile.width - margin * 2 - l * margin * 2
					y: l * (textH + textMargin) + profile.midY - margin / 1.5
					height: textH
					backgroundColor: textBg
	bgCover.bringToFront()
	bgCover.height = scroll.content.height
			
createLayout(2, 30, 20)

