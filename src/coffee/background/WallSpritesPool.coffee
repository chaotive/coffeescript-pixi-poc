class WallSpritesPool
  constructor: ->
    @createWindows()
    @createDecorations()
    @createFrontEdges()
    @createBackEdges()
    @createSteps()

  createDecorations: ->
    @decorations = [];
    @addDecorationSprites(6, "decoration_01")
    @addDecorationSprites(6, "decoration_02")
    @addDecorationSprites(6, "decoration_03")
    @shuffle(@decorations)

  createFrontEdges: ->
    @frontEdges = []
    @addFrontEdgeSprites(2, "edge_01")
    @addFrontEdgeSprites(2, "edge_02")
    @shuffle(@frontEdges)

  createBackEdges: ->
    @backEdges = []
    @addBackEdgeSprites(2, "edge_01")
    @addBackEdgeSprites(2, "edge_02")
    @shuffle(@backEdges)

  createSteps: ->
    @steps = [];
    @addStepSprites(2, "step_01");

  borrowWindow: ->
    @windows.shift()

  returnWindow: (sprite) ->
    @windows.push(sprite)

  borrowDecoration: ->
    @decorations.shift()

  returnDecoration: (sprite) ->
    @decorations.push(sprite)

  borrowFrontEdge: ->
    @frontEdges.shift()

  returnFrontEdge: (sprite) ->
    @frontEdges.push(sprite)

  borrowBackEdge: ->
    @backEdges.shift()

  returnBackEdge: (sprite) ->
    @backEdges.push(sprite)

  borrowStep: ->
    @steps.shift()

  returnStep: (sprite) ->
    @steps.push(sprite)

  createWindows: ->
    @windows = []
    @addWindowSprites(6, "window_01")
    @addWindowSprites(6, "window_02")
    @shuffle(@windows)

  addWindowSprites: (amount, frameId) ->
    f(i) for i in [0...amount]
    f = (i) ->
      sprite = PIXI.Sprite.fromFrame(frameId)
      @windows.push(sprite)

  addDecorationSprites: (amount, frameId) ->
    f(i) for i in [0...amount]
    f = (i) ->
      sprite = new PIXI.Sprite(PIXI.Texture.fromFrame(frameId))
      @decorations.push(sprite)

  addFrontEdgeSprites: (amount, frameId) ->
    f(i) for i in [0...amount]
    f = (i) ->
      sprite = new PIXI.Sprite(PIXI.Texture.fromFrame(frameId))
      @frontEdges.push(sprite)

  addBackEdgeSprites: (amount, frameId) ->
    f(i) for i in [0...amount]
    f = (i) ->
      sprite = new PIXI.Sprite(PIXI.Texture.fromFrame(frameId))
      sprite.anchor.x = 1
      sprite.scale.x = -1
      @backEdges.push(sprite)

  addStepSprites: (amount, frameId) ->
    f(i) for i in [0...amount]
    f = (i) ->
      sprite = new PIXI.Sprite(PIXI.Texture.fromFrame(frameId))
      sprite.anchor.y = 0.25
      @steps.push(sprite)

  shuffle: (array) ->
    len = array.length
    shuffles = len * 3
    f(i) for i in [0...shuffles]
    f = (i) ->
      wallSlice = array.pop()
      pos = Math.floor(Math.random() * (len-1))
      array.splice(pos, 0, wallSlice)
