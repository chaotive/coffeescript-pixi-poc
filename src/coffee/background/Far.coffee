class Far extends PIXI.TilingSprite
  constructor: ->
    texture = PIXI.Texture.fromImage("resources/bg-far.png")
    PIXI.TilingSprite.call(this, texture, 512, 256);

    @position.x = 0;
    @position.y = 0;
    @tilePosition.x = 0;
    @tilePosition.y = 0;
    @viewportX = 0;

  setViewportX: (newViewportX) ->
    distanceTravelled = newViewportX - @viewportX
    @viewportX = newViewportX;
    @tilePosition.x -= (distanceTravelled * props.game.Far.DELTA_X);
    console.log("cambio piola")