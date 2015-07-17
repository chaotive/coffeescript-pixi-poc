class Main
  @MIN_SCROLL_SPEED = 5
  @MAX_SCROLL_SPEED = 15
  @SCROLL_ACCELERATION = 0.005

  constructor: ->
    console.log("Main running...")
    @stage = new PIXI.Stage(0x66FF99)
    @renderer = PIXI.autoDetectRenderer(
      512
      384
      {view:document.getElementById("game-canvas")}
    )
    @scrollSpeed = Main.MIN_SCROLL_SPEED
    @loadSpriteSheet()

  update: ->
    @scroller.moveViewportXBy(@scrollSpeed)
    @scrollSpeed += Main.SCROLL_ACCELERATION
    if (@scrollSpeed > Main.MAX_SCROLL_SPEED)
      @scrollSpeed = Main.MAX_SCROLL_SPEED

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
    for x in [0...num]
      if (i % 2 == 0)
        sprite = @pool.borrowWindow()
      else
        sprite = @pool.borrowDecoration()
      sprite.position.x = -32 + (i * 64)
      sprite.position.y = 128

      @wallSlices.push(sprite)
      @stage.addChild(sprite)

  returnWallSprites: ->
    for x in [0...@wallSlices.length]
      sprite = @wallSlices[i]
      @stage.removeChild(sprite)
      if (i % 2 == 0)
        @pool.returnWindow(sprite)
      else
        @pool.returnDecoration(sprite)

    @wallSlices = []
