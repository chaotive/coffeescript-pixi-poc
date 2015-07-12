class Main
  constructor: (@name) ->
    console.log("init() successfully called.")
    @stage = new PIXI.Stage(0x66FF99)
    @renderer = PIXI.autoDetectRenderer(
      512
      384
      {view:document.getElementById("game-canvas")}
    )
    @loadSpriteSheet()

  loadSpriteSheet: ->
    console.log("Loading sprie sheet: " + props.game.SCROLL_SPEED)
