class MapBuilder
  @WALL_HEIGHTS = [
    256
    224
    192
    160
    128
  ]

  constructor: (walls) ->
    @walls = walls
    @createMap()

  createMap: () ->

  addWallFront: (heightIndex) ->
    y = MapBuilder.WALL_HEIGHTS[heightIndex]
    @walls.addSlice(SliceType.FRONT, y)

  addWallBack: (heightIndex) ->
    y = MapBuilder.WALL_HEIGHTS[heightIndex]
    @walls.addSlice(SliceType.BACK, y)

  addWallMid: (heightIndex, spanLength) ->
    y = MapBuilder.WALL_HEIGHTS[heightIndex]
    for i in [0...spanLength]
      if (i % 2 == 0) @walls.addSlice(SliceType.WINDOW, y)
      else @walls.addSlice(SliceType.DECORATION, y)

  addWallStep: (heightIndex) ->
    y = MapBuilder.WALL_HEIGHTS[heightIndex]
    @walls.addSlice(SliceType.STEP, y)
