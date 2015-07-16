class Mid extends PIXI.TilingSprite
  constructor: ->
    texture = PIXI.Texture.fromImage("resources/bg-mid.png");
    super(texture, 512, 256);

    @position.x = 0;
    @position.y = 128;
    @tilePosition.x = 0;
    @tilePosition.y = 0;

    @viewportX = 0;

  setViewportX: (newViewportX) ->
    distanceTravelled = newViewportX - @viewportX;
    @viewportX = newViewportX;
    @tilePosition.x -= (distanceTravelled * props.game.Mid.DELTA_X)