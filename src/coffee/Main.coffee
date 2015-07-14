class Main
  constructor: ->
    console.log("Main running... ")
    @stage = new PIXI.Stage(0x66FF99)
    @renderer = PIXI.autoDetectRenderer(
      512
      384
      {view:document.getElementById("game-canvas")}
    )
    @loadSpriteSheet()
    console.log("sorryh wn")

  update: ->
    @scroller.moveViewportXBy(props.game.SCROLL_SPEED)
    @renderer.render(@stage)
    requestAnimFrame(@update.bind(this));

  loadSpriteSheet: ->
    assetsToLoad = ["resources/wall.json", "resources/bg-mid.png",
                        "resources/bg-far.png"]
    loader = new PIXI.AssetLoader(assetsToLoad)
    loader.onComplete = @spriteSheetLoaded.bind(this);
    loader.load()

  spriteSheetLoaded: ->
    @scroller = new Scroller(@stage);
    requestAnimFrame(@update.bind(this));

  borrowWallSprites: (num) ->
    f(x) for x in [0...num]
    f = (i) ->
      if (i % 2 == 0) sprite = @pool.borrowWindow()
      else sprite = @pool.borrowDecoration()
      sprite.position.x = -32 + (i * 64)
      sprite.position.y = 128

      @wallSlices.push(sprite)
      @stage.addChild(sprite)

  returnWallSprites: ->
    f(x) for x in [0...@wallSlices.length]
    f = (i) ->
        sprite = @wallSlices[i]
        @stage.removeChild(sprite)
        if (i % 2 == 0) @pool.returnWindow(sprite)
        else @pool.returnDecoration(sprite)

    @wallSlices = []
