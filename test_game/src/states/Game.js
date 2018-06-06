/* globals __DEV__ */
import Phaser from 'phaser'
import serverClient from '../serverClient';

export default class extends Phaser.State {
  init() { }
  preload() {
    this.server = new serverClient( )
    this.server.subscribe()
  }

  create() {
    this.platform = game.add.graphics(
      game.world.width * this.server.platform.position.x - 50,
      game.world.centerY + 196
    );

    this.platform.lineStyle(6, 0x000000);
    this.platform.moveTo(0, 0);
    this.platform.lineTo(100, 0);

    this.ball = game.add.graphics(0, 0);

    this.ball.beginFill(0xFF0000, 1);
    this.ball.drawCircle(0, 0, 30);

    this.leftKey = game.input.keyboard.addKey(Phaser.Keyboard.LEFT);
    this.rightKey = game.input.keyboard.addKey(Phaser.Keyboard.RIGHT);
  }

  render() {
    if (this.leftKey.isDown && this.platform.x > 0) {
      this.server.channel.perform('platform_left', { active: true })
    }
    if (this.rightKey.isDown && this.platform.x < game.width - 106 ) {
      this.server.channel.perform('platform_right', { active: true })
    }

    this.platform.x = this.server.platform.position.x * game.width

    this.ball.x = this.server.ball.position.x * game.width
    this.ball.y = this.server.ball.position.y * game.height

  }
}
