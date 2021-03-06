# Get Windows colors, type ramp, and motion library out of the box
# For more info see https://github.com/Microsoft/windows-framer-toolkit
{SystemColor} = require 'SystemColor'
{Type} = require 'type'
motion = require 'motionCurves'
{Button} = require 'windows-framer-toolkit-master/Controls/Actions/Button'
{ContextMenu} = require 'windows-framer-toolkit-master/Controls/Overlays/ContextMenu'

# JSON calls
window.exerciseData = require './exercise_data.json'
window.currentExercise = 0
window.currentChar = 0

# If you want the purple outlines, comment this out
# Framer.Extras.Hints.disable()

Utils.insertCSS('@import url(https://fonts.googleapis.com/css?family=Roboto);')

# Feedback layer definitions (comments in fields represent default values for elements when they appear)

# Correct/incorrect layers and type


incorrectLayer = new Layer
	width: 400
	height: 110 #110
	backgroundColor: "#F85B5B"
	x: Align.center()
	y: Align.bottom(110)
	visible: false

correctLayer = new Layer
	width: 400
	height: 110 #110
	backgroundColor: "#82C57C"
	x: Align.center()
	y: Align.bottom(110)
	visible: false

# animation options

incorrectLayer.animationOptions = 
	time: .4

correctLayer.animationOptions = 
	time: .4

# active state definitions

correctLayer.states.active =
	y: Align.bottom()

incorrectLayer.states.active =
	y: Align.bottom()

# correctness text definitions

correctText = new Type
	parent: correctLayer
	color: "#45863F"
	text: "You are correct"
	uwpStyle: "body"
	x: Align.center(-110)
	y: Align.bottom(-78)
	opacity: 0 #100

incorrectText = new Type
	parent: incorrectLayer
	color: "#9A2525"
	text: "Correct answer shown above"
	uwpStyle: "body"
	x: Align.center(-60)
	y: Align.bottom(-78)
	opacity: 0 #100

# active states definition

correctText.states.active =
	opacity: 100

incorrectText.states.active = 
	opacity: 100

# Definition of main button

checkButton = new Layer
	label: "CHECK"
	width: 350
	height: 50
	x: Align.center()
	y: Align.bottom(-20)
	borderRadius: 15
	shadowBlur: 10
	shadowY: 9
	shadowColor: "rgba(47, 89, 43, 0.4)"
	backgroundColor: "#45863F"
	visible: true

continueButton = new Layer
	label: "CONTINUE"
	width: 350
	height: 50
	x: Align.center()
	y: Align.bottom(-20)
	borderRadius: 15
	shadowBlur: 10
	shadowY: 9
	shadowColor: "rgba(47, 89, 43, 0.4)"
	backgroundColor: "#45863F"
	visible: false

checkButton.states.correct = 
	backgroundColor: "#45863F"
	label: "CHECK"
	shadowColor: "rgba(47, 89, 43, 0.4)"

checkButton.states.incorrect = 
	backgroundColor: "#9A2525"
	label: "CHECK"
	shadowColor: "rgba(154, 37, 37, 0.4)"

continueButton.states.correct =
	backgroundColor: "#45863F"
	label: "CONTINUE"
	shadowColor: "rgba(47, 89, 43, 0.4)"

continueButton.states.incorrect = 
	backgroundColor: "#9A2525"
	label: "CONTINUE"
	shadowColor: "rgba(154, 37, 37, 0.4)"

checkButton.animationOptions = 
	time: .1

continueButton.animationOptions = 
	time: .1

# Headings for exercises generated dynamically from JSON

# define parent layer

topTypeParent = new Layer
	width: 400
	height: 80
	backgroundColor:"#FFFFFF"
	x: Align.center()
	y: Align.top()

titleType = new Type
	width: 400
	parent: topTypeParent
	uwpStyle: "header"
	text: window.exerciseData[window.currentExercise].header
	x: Align.left(-17)
	y: Align.top()
	scale: .75

definitionSubType = new Type
	width: 300
	parent: topTypeParent
	uwpStyle: "subheader"
	text: window.exerciseData[window.currentExercise].subheader
	x: Align.left(-34)
	y: Align.top(42)
	scale: .5

# Main Tile definition and properties

writingTile = new Layer
	visible: true
	backgroundColor: "#FFFFFF"
	borderWidth: 1.5
	borderColor: "#ababab"
	width: 320
	height: 320
	x: Align.center()
	y: Align.center(20)
	borderRadius: 15
	shadowBlur: 10
	shadowY: 9
	shadowColor: "rgba(196, 196, 196, 0.6)"

writingTile.animationOptions =
	time: .2

# shift tile up on
writingTile.animate
	y: Align.center()

writingTileImage = new Layer
	width: 280
	height: 280
	backgroundColor: "transparent"
	x: Align.center()
	y: Align.center()
	visible: true
	parent: writingTile
	image: window.exerciseData[window.currentExercise].traceImages[0]


# Tiles for recognition and matching

# parent tile

parentTile = new Layer
	width: 350
	height: 350
	x: Align.center()
	y: Align.center()
	backgroundColor: "transparent"

recogTile1 = new Layer
	name: "woman"
	borderColor: "#ababab"
	parent: parentTile
	width: 150
	height: 150
	x: Align.left()
	y: Align.top(20)
	borderWidth: 1.5
	borderColor: "#ababab"
	borderRadius: 15
	shadowBlur: 10
	shadowY: 9
	shadowColor: "rgba(196, 196, 196, 0.6)"
	visible: false
	backgroundColor:"#FFFFFF"
	image: "images/recogTile1.png"

recogTile1.states.load =
	backgroundColor: "#FFFFFF"
	opacity: 1
	borderColor:"#ABABAB"
	y: Align.top()

recogTile1.states.click =
	borderColor:"#1AA0A9"
	backgroundColor: "#ECFEFF"
	opacity: .99

recogTile1.states.incorrect =
	borderColor: "#B32E2E"
	backgroundColor: "rgba(248, 91, 91, .6)"

recogTile2 = new Layer
	name: "heart"
	borderColor: "#ababab"
	parent: parentTile
	width: 150
	height: 150
	x: Align.right()
	y: Align.top(20)
	borderWidth: 1.5
	borderColor: "#ababab"
	borderRadius: 15
	shadowBlur: 10
	shadowY: 9
	shadowColor: "rgba(196, 196, 196, 0.6)"
	visible: false
	backgroundColor:"#FFFFFF"
	image: "images/recogTile2.png"

recogTile2.states.load =
	backgroundColor: "#FFFFFF"
	opacity: 1
	borderColor:"#ABABAB"
	y: Align.top()

recogTile2.states.click =
	borderColor:"#1AA0A9"
	backgroundColor: "#ECFEFF"
	opacity: .99

recogTile2.states.incorrect =
	borderColor: "#B32E2E"
	backgroundColor: "rgba(248, 91, 91, .6)"

recogTile3 = new Layer
	name: "hand"
	borderColor: "#ababab"
	parent: parentTile
	width: 150
	height: 150
	x: Align.right()
	y: Align.bottom(20)
	borderWidth: 1.5
	borderColor: "#ababab"
	borderRadius: 15
	shadowBlur: 10
	shadowY: 9
	shadowColor: "rgba(196, 196, 196, 0.6)"
	visible: false
	backgroundColor:"#FFFFFF"
	image: "images/recogTile3.png"

recogTile3.states.load =
	backgroundColor: "#FFFFFF"
	opacity: 1
	borderColor:"#ABABAB"
	y: Align.bottom()

recogTile3.states.click =
	borderColor:"#1AA0A9"
	backgroundColor: "#ECFEFF"
	opacity: .99

recogTile3.states.incorrect =
	borderColor: "#B32E2E"
	backgroundColor: "rgba(248, 91, 91, .6)"

recogTile4 = new Layer
	name: "person"
	borderColor: "#ababab"
	parent: parentTile
	width: 150
	height: 150
	x: Align.left()
	y: Align.bottom(20)
	borderWidth: 1.5
	borderColor: "#ababab"
	borderRadius: 15
	shadowBlur: 10
	shadowY: 9
	shadowColor: "rgba(196, 196, 196, 0.6)"
	visible: false
	backgroundColor:"#FFFFFF"
	image: "images/recogTile4.png"

recogTile4.states.load =
	backgroundColor: "#FFFFFF"
	opacity: 1
	borderColor:"#ABABAB"
	y: Align.bottom()

recogTile4.states.click =
	borderColor:"#1AA0A9"
	backgroundColor: "#ECFEFF"
	opacity: .99

recogTile4.states.incorrect =
	borderColor: "#B32E2E"
	backgroundColor: "rgba(248, 91, 91, .6)"

parentMatching = new Layer
	visible: true
	width: 350
	height: 350
	x: Align.center()
	y: Align.center()
	backgroundColor: "transparent"

matchingTile1 = new Layer
	name: "heart"
	borderColor: "#ababab"
	parent: parentMatching
	width: 100
	height: 100
	x: Align.left()
	y: Align.top(20)
	image: "images/match1.png"
	borderWidth: 1.5
	borderColor: "#ababab"
	borderRadius: 15
	shadowBlur: 10
	shadowY: 9
	shadowColor: "rgba(196, 196, 196, 0.6)"
	visible: false
	backgroundColor:"#FFFFFF"

matchingTile1.states.incorrect =
	borderColor: "#B32E2E"
	backgroundColor: "rgba(248, 91, 91, .6)"

matchingTile1.states.correct =
	opacity: .4

matchingTile1.states.click = 
	borderColor:"#1AA0A9"
	backgroundColor: "#ECFEFF"
	y: Align.top()
	opacity: .99

matchingTile1.states.load =
	opacity: 1
	borderColor:"#ABABAB"
	backgroundColor: "#FFFFFF"
	y: Align.top()

matchingTile2 = new Layer
	name: "person"
	borderColor: "#ababab"
	parent: parentMatching
	width: 100
	height: 100
	x: Align.center()
	y: Align.top(20)
	image: "images/match2.png"
	borderWidth: 1.5
	borderColor: "#ababab"
	borderRadius: 15
	shadowBlur: 10
	shadowY: 9
	shadowColor: "rgba(196, 196, 196, 0.6)"
	visible: false
	backgroundColor:"#FFFFFF"

matchingTile2.states.incorrect =
	borderColor: "#B32E2E"
	backgroundColor: "rgba(248, 91, 91, .6)"

matchingTile2.states.correct =
	opacity: .4

matchingTile2.states.click = 
	borderColor:"#1AA0A9"
	backgroundColor: "#ECFEFF"
	y: Align.top()
	opacity: .99

matchingTile2.states.load =
	opacity: 1
	borderColor:"#ABABAB"
	backgroundColor: "#FFFFFF"
	y: Align.top()

matchingTile3 = new Layer
	name: "person"
	borderColor: "#ababab"
	parent: parentMatching
	width: 100
	height: 100
	x: Align.right()
	y: Align.top(20)
	image: "images/match3.png"
	borderWidth: 1.5
	borderColor: "#ababab"
	borderRadius: 15
	shadowBlur: 10
	shadowY: 9
	shadowColor: "rgba(196, 196, 196, 0.6)"
	visible: false
	backgroundColor:"#FFFFFF"

matchingTile3.states.incorrect =
	borderColor: "#B32E2E"
	backgroundColor: "rgba(248, 91, 91, .6)"

matchingTile3.states.correct =
	opacity: .4

matchingTile3.states.click = 
	borderColor:"#1AA0A9"
	backgroundColor: "#ECFEFF"
	y: Align.top()
	opacity: .99

matchingTile3.states.load =
	opacity: 1
	borderColor: "#ABABAB"
	backgroundColor: "#FFFFFF"
	y: Align.top()

matchingTile4 = new Layer
	name: "heart"
	borderColor: "#ababab"
	parent: parentMatching
	width: 100
	height: 100
	x: Align.left()
	y: Align.bottom(-90)
	image: "images/match4.png"
	borderWidth: 1.5
	borderColor: "#ababab"
	borderRadius: 15
	shadowBlur: 10
	shadowY: 9
	shadowColor: "rgba(196, 196, 196, 0.6)"
	visible: false
	backgroundColor:"#FFFFFF"

matchingTile4.states.incorrect =
	borderColor: "#B32E2E"
	backgroundColor: "rgba(248, 91, 91, .6)"

matchingTile4.states.correct =
	opacity: .4

matchingTile4.states.click = 
	borderColor:"#1AA0A9"
	backgroundColor: "#ECFEFF"
	y: Align.bottom(-110)
	opacity: .99

matchingTile4.states.load =
	opacity: 1
	borderColor:"#ABABAB"
	backgroundColor: "#FFFFFF"
	y: Align.bottom(-110)

matchingTile5 = new Layer
	name: "hand"
	borderColor: "#ababab"
	parent: parentMatching
	width: 100
	height: 100
	x: Align.center()
	y: Align.bottom(-90)
	image: "images/match5.png"
	borderWidth: 1.5
	borderColor: "#ababab"
	borderRadius: 15
	shadowBlur: 10
	shadowY: 9
	shadowColor: "rgba(196, 196, 196, 0.6)"
	visible: false
	backgroundColor:"#FFFFFF"

matchingTile5.states.incorrect =
	borderColor: "#B32E2E"
	backgroundColor: "rgba(248, 91, 91, .6)"

matchingTile5.states.correct =
	opacity: .4

matchingTile5.states.click = 
	borderColor:"#1AA0A9"
	backgroundColor: "#ECFEFF"
	y: Align.bottom(-110)
	opacity: .99

matchingTile5.states.load =
	opacity: 1
	borderColor:"#ABABAB"
	backgroundColor: "#FFFFFF"
	y: Align.bottom(-110)

matchingTile6 = new Layer
	name: "hand"
	borderColor: "#ababab"
	parent: parentMatching
	width: 100
	height: 100
	x: Align.right()
	y: Align.bottom(-90)
	image: "images/match6.png"
	borderWidth: 1.5
	borderColor: "#ababab"
	borderRadius: 15
	shadowBlur: 10
	shadowY: 9
	shadowColor: "rgba(196, 196, 196, 0.6)"
	visible: false
	backgroundColor:"#FFFFFF"

matchingTile6.states.incorrect =
	borderColor: "#B32E2E"
	backgroundColor: "rgba(248, 91, 91, .6)"

matchingTile6.states.correct =
	opacity: .4

matchingTile6.states.click = 
	borderColor:"#1AA0A9"
	backgroundColor: "#ECFEFF"
	y: Align.bottom(-110)
	opacity: .99

matchingTile6.states.load =
	opacity: 1
	borderColor:"#ABABAB"
	backgroundColor: "#FFFFFF"
	y: Align.bottom(-110)

# hint button and pronunciation aide

topOfTileParent = new Layer
	backgroundColor: "transparent"
	height: 50
	x: Align.center()
	y: Align.center(-200)
	borderStyle: "dotted"
	borderWidth:
        top: 0
        right: 0
        bottom: 8
        left: 0

wordDisplayType = new Type
	uwpStyle: "subheader"
	text: window.exerciseData[window.currentExercise].pronunciation
	x: Align.center(-95)
	y: Align.center(-215)
	visible: true

hintButton = new Layer
	parent: writingTile
	width: 50
	height: 50
	backgroundColor: "#1AA0A9"
	label: "HINT"
	borderRadius: 15
	shadowBlur: 10
	shadowY: 4
	shadowColor: "rgba(26, 159, 169, 0.35)"
	x: Align.left(-75)
	y: Align.center()
	opacity: 0

hintButton.states.load = 
	backgroundColor: "#1AA0A9"
	opacity: 1

hintButton.states.used = 
	backgroundColor: "#ababab"
	shadowColor:"#AFAFAF"
	opacity: .4

hintButton.animationOptions = 
	time: .2

usedHint = false

useHint = ->
	if !usedHint

		if window.currentExercise == 3
			wordDisplayType.visible = true
		
		writingTileImage.image = window.exerciseData[window.currentExercise].hintImage
		hintButton.animate "used"
	

hintButton.on "click", -> useHint()

# Interaction and correctness checking

# indicates whether the user is correct or not
answer = false

# listener: clickEvent

recogNumClicked = 0
recogAnswer = "person"
recogFinished = false

recognitionCheck = ->

	console.log(parentTile.children[3])

	for i in parentTile.children
		if i.opacity == .99
			if i.name == recogAnswer
				answer = true
				console.log("check")
				return

	for j in parentTile.children
		j.animate "load"

	parentTile.children[3].animate "click"
	answer = false

	recogFinished = true

recognitionEvent = (event, layer, n) ->

	if recogFinished
		return

	if layer.opacity == .99
		layer.animate "load"
	else
		for i in parentTile.children
			i.animate "load"
		layer.animate "click"


numSuccessfulMatches = 0
matchingNumClicked = 0

setDefaultMatching = (tile1,tile2) ->
	tile1.animate "load"
	tile2.animate "load"

matchingEvent = (event, layer, n) ->

	# basic state and value change1

	if layer.opacity == .4
		return

	if layer.opacity != .99
		
		matchingNumClicked = ++matchingNumClicked
		layer.animate "click"
		layer.opacity = .99
		
		# check answers based on name
		if matchingNumClicked >= 2
			lstName = []
			lstIndex = []
			for n in [parentMatching.children.length - 1..0]
				if parentMatching.children[n].opacity == .99
					lstName.push parentMatching.children[n].name
					lstIndex.push n

			
			if lstName[0] == lstName[1]
				setDefaultMatching(parentMatching.children[lstIndex[0]], parentMatching.children[lstIndex[1]])
				
				parentMatching.children[lstIndex[0]].backgroundColor = "#FFFFFF"
				parentMatching.children[lstIndex[1]].backgroundColor = "#FFFFFF"
				parentMatching.children[lstIndex[0]].borderColor = "#ABABAB"
				parentMatching.children[lstIndex[1]].borderColor = "#ABABAB"

				parentMatching.children[lstIndex[0]].animate "correct"
				parentMatching.children[lstIndex[1]].animate "correct"
				matchingNumClicked = 0
				numSuccessfulMatches = ++numSuccessfulMatches

				if numSuccessfulMatches == 3
					answer = true
					userCorrect()

				return
			else
				parentMatching.children[lstIndex[0]].animate "incorrect"
				parentMatching.children[lstIndex[1]].animate "incorrect"
				matchingNumClicked = 0

				callback = () -> 
					setDefaultMatching(parentMatching.children[lstIndex[0]], parentMatching.children[lstIndex[1]])
				setTimeout callback, 300



		return


	layer.backgroundColor = "#FFFFFF"
	layer.borderColor = "#ABABAB"
	layer.opacity = 1
	matchingNumClicked = 0
	layer.animate "load"

	
for n in [parentMatching.children.length - 1..0]
	parentMatching.children[n].on Events.Click, (event, layer) ->
		matchingEvent(event, layer, n)

for n in [parentTile.children.length - 1..0]
	parentTile.children[n].on Events.Click, (event, layer) ->
		recognitionEvent(event, layer, n)

updateChar = ->
	window.currentChar = ++window.currentChar
	if window.currentChar > 3
		window.currentChar = 0
	writingTileImage.image = window.exerciseData[window.currentExercise].traceImages[window.currentChar]




setAnswer = (code) ->
	if code == 48 # 0 on keyboard
		answer = false
	else if code == 49 # 1 on keyboard
		answer = true
	else if code == 50 # 2 on keyboard
		updateChar()

# check for event keycode and run to setAnswer

window.addEventListener "keypress", (e) => setAnswer(e.keyCode)

checkButton.on "click", -> userCorrect()
continueButton.on "click", -> moveExercise()

restoreDefault = ->

	window.currentChar = 0

	if window.currentExercise >= 6
		return null

	switch window.currentExercise

		when 5
			wordDisplayType.visible = false
			topOfTileParent.visible = false
			writingTile.visible = false
			titleType.scale = .5
			titleType.x = Align.left(-105)
			titleType.y = 0
			titleType.width = 600

			for i in parentTile.children
				i.visible = false
		
			for j in parentMatching.children
				j.opacity = 1
				j.visible = true
				j.animationOptions = 
					time: .2
				j.animate "load"


		when 4
			wordDisplayType.visible = false
			topOfTileParent.visible = false
			writingTile.visible = false
			titleType.scale = .5
			titleType.x = Align.left(-105)
			titleType.y = 0
			titleType.width = 600

			for tile in parentTile.children
				tile.visible = true
				tile.animationOptions =
					time: .2
				tile.animate "load"
			recogFinished = false

		when 3
			hintButton.animate "load"
			writingTileImage.image = window.exerciseData[window.currentExercise].traceImages[window.currentChar]
			wordDisplayType.text = window.exerciseData[window.currentExercise].pronunciation
			wordDisplayType.visible = false

		when 2
			hintButton.animate "load"
			writingTileImage.image = window.exerciseData[window.currentExercise].traceImages[window.currentChar]
			wordDisplayType.text = window.exerciseData[window.currentExercise].pronunciation

		when 0, 1
			hintButton.animate "default"
			wordDisplayType.text = window.exerciseData[window.currentExercise].pronunciation
			writingTileImage.image = window.exerciseData[window.currentExercise].traceImages[window.currentChar]


	checkButton.animate "default"
	continueButton.animate "default"

	correctLayer.animate "default"
	incorrectLayer.animate "default"

	correctText.animate "default"
	incorrectText.animate "default"

	titleType.text = window.exerciseData[window.currentExercise].header
	definitionSubType.text = window.exerciseData[window.currentExercise].subheader


	answer = false
	usedHint = false


moveExercise = ->

	if answer
		window.currentExercise = ++window.currentExercise

	restoreDefault()

	#Reset height of correct and incorrect Layers, opacity of correct and incorrect Text, content of checkButton

userCorrect = ->

	if window.currentExercise == 4
		recognitionCheck()
		console.log(answer)

	if answer
		# Change height of correct Layer, opacity of correct Text
		if window.exerciseData[window.currentExercise].exerciseName == "writeChinese" or window.exerciseData[window.currentExercise].exerciseName == "writeRussian" or window.exerciseData[window.currentExercise].exerciseName == "traceRussian" or window.exerciseData[window.currentExercise].exerciseName == "traceChinese"
			writingTileImage.image = window.exerciseData[window.currentExercise].correctImage

		checkButton.animate "correct"
		checkButton.visible = false

		continueButton.visible = true
		continueButton.animate "correct"

		correctLayer.animate "active"
		correctLayer.visible = true

		correctText.animate "active"

		if window.currentExercise == 3
			wordDisplayType.visible = true

	else 
		if window.exerciseData[window.currentExercise].exerciseName == "writeChinese" or window.exerciseData[window.currentExercise].exerciseName == "writeRussian" or window.exerciseData[window.currentExercise].exerciseName == "traceRussian" or window.exerciseData[window.currentExercise].exerciseName == "traceChinese"
			writingTileImage.image = window.exerciseData[window.currentExercise].incorrectImages[window.currentChar]

		checkButton.animate "incorrect"
		checkButton.visible = false

		continueButton.visible = true
		continueButton.animate "incorrect"

		incorrectLayer.animate "active"
		incorrectLayer.visible = true

		incorrectText.animate "active"

		if window.currentExercise == 3
			wordDisplayType.visible = true



# TODO
# Add pronunciation interaction
# Add interactive elements for 5th and 6th exercises and their answer checking logic
# add sound
# polish traceRussian and writeRussian tests

# All exercises, if failed, should return to the default with the same exercise, giving the users another chance

# use framer property addListener to assign functions to tiles.