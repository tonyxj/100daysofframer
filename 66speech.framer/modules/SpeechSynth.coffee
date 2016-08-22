class exports.SpeechSynth extends Framer.BaseClass
	constructor: (options={}) ->
		@_utterance = new SpeechSynthesisUtterance()
		@_voices = window.speechSynthesis.getVoices()

		if options.voice
			options.voice = @_voices.filter((voice) -> voice.name == "#{options.voice}")[0]

		for option of options
			@_utterance["#{option}"] = options["#{option}"]

	speak: ->
		window.speechSynthesis.speak(@_utterance)

	cancel: ->
		window.speechSynthesis.cancel(@_utterance)

	pause: ->
		window.speechSynthesis.pause(@_utterance)

	resume: ->
		window.speechSynthesis.resume(@_utterance)

	@define "voices",
		get: -> 
			voices = []
			
			for voice in @_voices
				voices[_.indexOf(@_voices, voice)] = voice.name 

			return voices

	@define "isPending",
		get: -> window.speechSynthesis.pending
	@define "isSpeaking",
		get: -> window.speechSynthesis.speaking
	@define "isPaused", 
		get: -> window.speechSynthesis.paused
	@define "text",
		get: -> @_utterance.text
		set: (value) -> @_utterance.text = value
	@define "lang",
		get: -> @_utterance.lang
		set: (value) -> @_utterance.lang = value
	@define "volume",
		get: -> @_utterance.volume
		set: (value) -> @_utterance.volume = value
	@define "rate",
		get: -> @_utterance.rate
		set: (value) -> @_utterance.rate = value
	@define "pitch",
		get: -> @_utterance.pitch
		set: (value) -> @_utterance.pitch = value
