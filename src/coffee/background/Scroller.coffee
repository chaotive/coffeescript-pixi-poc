class Scroller
  constructor: (stage) ->
    @far = new Far()
    stage.addChild(@far)

    @mid = new Mid()
    stage.addChild(@mid)

    @viewportX = 0

  setViewportX: (viewportX) ->
    @viewportX = viewportX
    @far.setViewportX(viewportX)
    @mid.setViewportX(viewportX)

  getViewportX: ->
    @viewportX

  moveViewportXBy: (units) ->
    newViewportX = @viewportX + units;
    this.setViewportX(newViewportX);