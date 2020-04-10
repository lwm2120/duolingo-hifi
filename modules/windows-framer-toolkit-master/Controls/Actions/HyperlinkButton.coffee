# HyperlinkButton requires these modules. Please include them in your /modules directory
{Type} = require "Type"
{SystemColor} = require "SystemColor"

class exports.HyperlinkButton extends Layer
	constructor: (@options={}) ->
		@options.label ?= "Label"
		@options.enabled ?= true
		@options.width ?= 120
		@options.height ?= 32
		@options.backgroundColor ?= SystemColor.transparent
		super @options
		@createLayers()

	@define "label",
		get: ->
			@options.label
		set: (value) ->
			@options.label = value
			if @labelText?
				@createLayers()

	@define "enabled",
		get: ->
			@options.enabled
		set: (value) ->
			@options.enabled = value
			if @labelText
				@createLayers()

	createLayers: ->
		if @labelText?
			@labelText.destroy()

		@labelText = new Type
			parent: @
			name: "Label"
			text: @options.label
			textDecoration: "underline"
			whiteSpace: "nowrap"
			padding:
				top: 5
				bottom: 7

		@.updateVisuals()

		# EVENTS
		@labelText.onMouseUp ->
			@.parent.updateVisuals("mouseup")

		@labelText.onMouseDown ->
			@.parent.updateVisuals("mousedown")

		@labelText.onMouseOver ->
			@.parent.updateVisuals("mouseover")

		@labelText.onMouseOut ->
			@.parent.updateVisuals("mouseout")

	updateVisuals: (curEvent) ->
		if @options.enabled
			switch curEvent
				when "mouseup"
					labelColor = SystemColor.baseMedium
				when "mousedown"
					labelColor = SystemColor.baseMediumLow
				when "mouseover"
					labelColor = SystemColor.baseMedium
				else
					labelColor = SystemColor.accent
		else
			labelColor = SystemColor.baseMediumLow

		@labelText.color = labelColor
