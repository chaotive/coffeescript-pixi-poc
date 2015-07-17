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
    @viewportX = @checkViewportXBounds(viewportX)
    prevViewportSliceX = @viewportSliceX
    @viewportSliceX = Math.floor(@viewportX/WallSlice.WIDTH)

    @removeOldSlices(prevViewportSliceX)
    @addNewSlices()

  removeOldSlices: (prevViewportSliceX) ->
    numOldSlices = @viewportSliceX - prevViewportSliceX;
    if (numOldSlices > Walls.VIEWPORT_NUM_SLICES)
      numOldSlices = Walls.VIEWPORT_NUM_SLICES
    for i in [prevViewportSliceX...(prevViewportSliceX + numOldSlices)]
      slice = @slices[i]
      if (slice.sprite != null)
        @returnWallSprite(slice.type, slice.sprite)
        @removeChild(slice.sprite)
        slice.sprite = null

  addNewSlices: () ->
    firstX = -(@viewportX % WallSlice.WIDTH)
    sliceIndex = 0
    for i in [@viewportSliceX...(@viewportSliceX + Walls.VIEWPORT_NUM_SLICES)]
      slice = @slices[i]
      if (slice.sprite == null && slice.type != SliceType.GAP)
        slice.sprite = @borrowWallSprite(slice.type)
        slice.sprite.position.x = firstX + (sliceIndex * WallSlice.WIDTH)
        slice.sprite.position.y = slice.y
        @addChild(slice.sprite)
      else if (slice.sprite != null)
        slice.sprite.position.x = firstX + (sliceIndex * WallSlice.WIDTH)
      sliceIndex++

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

  checkViewportXBounds: (viewportX) ->
    maxViewportX = (@slices.length - Walls.VIEWPORT_NUM_SLICES) * WallSlice.WIDTH
    if (viewportX < 0) viewportX = 0
    else if (viewportX > maxViewportX)
      viewportX = maxViewportX
    viewportX

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
