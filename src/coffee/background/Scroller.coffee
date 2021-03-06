class Scroller
  constructor: (stage) ->
    @far = new Far()
    stage.addChild(@far)

    @mid = new Mid()
    stage.addChild(@mid)

    @front = new Walls()
    stage.addChild(@front)

    @mapBuilder = new MapBuilder(@front)

    @viewportX = 0

  setViewportX: (viewportX) ->
    @viewportX = viewportX
    @far.setViewportX(viewportX)
    @mid.setViewportX(viewportX)
    @front.setViewportX(viewportX)

  getViewportX: ->
    @viewportX

  moveViewportXBy: (units) ->
    newViewportX = @viewportX + units
    @setViewportX(newViewportX)