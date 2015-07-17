class Walls extends PIXI.DisplayObjectContainer
  @VIEWPORT_WIDTH = 512
  @VIEWPORT_NUM_SLICES = Math.ceil(Walls.VIEWPORT_WIDTH/WallSlice.WIDTH) + 1

  constructor: ->
    super()
    @pool = new WallSpritesPool()
    @createLookupTables()
    @slices = []
    @createTestMap()
    @viewportX = 0
    @viewportSliceX = 0

  setViewportX: (viewportX) ->

  createLookupTables: ->
    @borrowWallSpriteLookup = []
    @borrowWallSpriteLookup[SliceType.FRONT] = @pool.borrowFrontEdge
    @borrowWallSpriteLookup[SliceType.BACK] = @pool.borrowBackEdge
    @borrowWallSpriteLookup[SliceType.STEP] = @pool.borrowStep
    @borrowWallSpriteLookup[SliceType.DECORATION] = @pool.borrowDecoration
    @borrowWallSpriteLookup[SliceType.WINDOW] = @pool.borrowWindow

    @returnWallSpriteLookup = [];
    @returnWallSpriteLookup[SliceType.FRONT] = @pool.returnFrontEdge
    @returnWallSpriteLookup[SliceType.BACK] = @pool.returnBackEdge
    @returnWallSpriteLookup[SliceType.STEP] = @pool.returnStep
    @returnWallSpriteLookup[SliceType.DECORATION] = @pool.returnDecoration
    @returnWallSpriteLookup[SliceType.WINDOW] = @pool.returnWindow

  borrowWallSprite: (sliceType) ->
    @borrowWallSpriteLookup[sliceType].call(@pool)

  returnWallSprite: (sliceType, sliceSprite) ->
    @returnWallSpriteLookup[sliceType].call(@pool, sliceSprite)

  addSlice: (sliceType, y) ->
    slice = new WallSlice(sliceType, y)
    @slices.push slice

  createTestWallSpan: () ->
    @addSlice(SliceType.FRONT, 192)
    @addSlice(SliceType.WINDOW, 192)
    @addSlice(SliceType.DECORATION, 192)
    @addSlice(SliceType.WINDOW, 192)
    @addSlice(SliceType.DECORATION, 192)
    @addSlice(SliceType.WINDOW, 192)
    @addSlice(SliceType.DECORATION, 192)
    @addSlice(SliceType.WINDOW, 192)
    @addSlice(SliceType.BACK, 192)

  createTestSteppedWallSpan: () ->
    @addSlice(SliceType.FRONT, 192)
    @addSlice(SliceType.WINDOW, 192)
    @addSlice(SliceType.DECORATION, 192)
    @addSlice(SliceType.STEP, 256)
    @addSlice(SliceType.WINDOW, 256)
    @addSlice(SliceType.BACK, 256)

  createTestGap: () ->
    @addSlice(SliceType.GAP);

  createTestMap: () ->
    for i in [0...10]
      @createTestWallSpan()
      @createTestGap()
      @createTestSteppedWallSpan()
      @createTestGap()
