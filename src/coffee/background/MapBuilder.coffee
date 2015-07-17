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
    @createWallSpan(3, 9, true)
    @createGap(1)
    @createWallSpan(1, 30)
    @createGap(1)
    @createWallSpan(2, 18)
    @createGap(1)
    @createSteppedWallSpan(2, 5, 28)
    @createGap(1)
    @createWallSpan(1, 10)
    @createGap(1)
    @createWallSpan(2, 6)
    @createGap(1)
    @createWallSpan(1, 8)
    @createGap(1)
    @createWallSpan(2, 6)
    @createGap(1)
    @createWallSpan(1, 8)
    @createGap(1)
    @createWallSpan(2, 7)
    @createGap(1)
    @createWallSpan(1, 16)
    @createGap(1)
    @createWallSpan(2, 6)
    @createGap(1)
    @createWallSpan(1, 22)
    @createGap(2)
    @createWallSpan(2, 14)
    @createGap(2)
    @createWallSpan(3, 8)
    @createGap(2)
    @createSteppedWallSpan(3, 5, 12)
    @createGap(3)
    @createWallSpan(0, 8)
    @createGap(3)
    @createWallSpan(1, 50)
    @createGap(20)

  createGap: (spanLength) ->
    for i in [0...spanLength]
      @walls.addSlice(SliceType.GAP)

  createWallSpan: (
    heightIndex, spanLength, noFront = false, noBack = false) ->

    if (noFront == false && spanLength > 0)
      @addWallFront(heightIndex)
      spanLength--

    if (noBack == true)
      temp = 0
    else
      temp = 1

    midSpanLength = spanLength - temp
    if (midSpanLength > 0)
      @addWallMid(heightIndex, midSpanLength)
      spanLength -= midSpanLength

    if (noBack == false && spanLength > 0)
      @addWallBack(heightIndex)

  createSteppedWallSpan: (heightIndex, spanALength, spanBLength) ->
    if (heightIndex < 2)
      heightIndex = 2
    @createWallSpan(heightIndex, spanALength, false, true)
    @addWallStep(heightIndex - 2)
    @createWallSpan(heightIndex - 2, spanBLength - 1, true, false)

  addWallFront: (heightIndex) ->
    y = MapBuilder.WALL_HEIGHTS[heightIndex]
    @walls.addSlice(SliceType.FRONT, y)

  addWallBack: (heightIndex) ->
    y = MapBuilder.WALL_HEIGHTS[heightIndex]
    @walls.addSlice(SliceType.BACK, y)

  addWallMid: (heightIndex, spanLength) ->
    y = MapBuilder.WALL_HEIGHTS[heightIndex]
    for i in [0...spanLength]
      if (i % 2 == 0)
        @walls.addSlice(SliceType.WINDOW, y)
      else
        @walls.addSlice(SliceType.DECORATION, y)

  addWallStep: (heightIndex) ->
    y = MapBuilder.WALL_HEIGHTS[heightIndex]
    @walls.addSlice(SliceType.STEP, y)
