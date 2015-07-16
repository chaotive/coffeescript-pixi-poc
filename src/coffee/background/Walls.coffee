class Walls extends PIXI.DisplayObjectContainer
  constructor: ->
    super()
    @pool = new WallSpritesPool()
    @createLookupTables()
    sprite = @borrowWallSprite(SliceType.WINDOW)
    console.log(sprite)
    @addChild(sprite)

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

    return

  borrowWallSprite: (sliceType) ->
    console.log(sliceType)
    @borrowWallSpriteLookup[sliceType].call(@pool)

  returnWallSprite: (sliceType, sliceSprite) ->
    @returnWallSpriteLookup[sliceType].call(@pool, sliceSprite)
