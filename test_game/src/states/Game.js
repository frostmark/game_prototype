/* globals __DEV__ */
import Phaser from 'phaser'
import actionCable from 'actioncable'

export default class extends Phaser.State {
  init() { }
  preload() { }

  create() {
    this.platform = game.add.graphics(game.world.centerX - 50, game.world.centerY + 196);

    this.platform.lineStyle(6, 0x000000);
    this.platform.moveTo(0, 0);
    this.platform.lineTo(100, 0);

    this.ball = game.add.graphics(0, 0);

    this.ball.beginFill(0xFF0000, 1);
    this.ball.drawCircle(0, 0, 30);
    this.ballDirection = {
      x: 5,
      y: 5
    }

    this.CableApp = {}

    this.CableApp.cable = actionCable.createConsumer('ws://localhost:3001/cable')

    this.CableApp.cable.subscriptions.create({ channel: "GameChannel", room: 'room' }, {
      connected: () => {
        console.log('connected');
      },

      disconnected: (data) => {
        console.log(data);
        console.log('disconnected');
      },

      rejected: (data) => {
        console.log(data);
        console.log('rejected');
      },

      received: (data) => {
        console.log(data);
        console.log('received');
      }
    })



    document.onclick = function(){console.log(1)};

    // ws.onmessage = function(e) {
    //   console.log(JSON.parse(e.data))
    // }
    this.leftKey = game.input.keyboard.addKey(Phaser.Keyboard.LEFT);
    this.rightKey = game.input.keyboard.addKey(Phaser.Keyboard.RIGHT);
  }

  render() {
    if (this.leftKey.isDown && this.platform.x > 0) {
        this.platform.x = this.platform.x - 7
    }
    if (this.rightKey.isDown && this.platform.x < game.width - 106 ) {
        this.platform.x = this.platform.x + 7
    }

    this.ball.x += this.ballDirection.x
    this.ball.y += this.ballDirection.y

    if ((this.ball.x > game.width - 15) || (this.ball.x <= 0)) {
      this.ballDirection.x = -this.ballDirection.x
    }

    if ((this.ball.y <= 0)) {
      this.ballDirection.y = - this.ballDirection.y
    }

    if ((this.ball.y > game.height - 15) && (this.ball.x >= this.platform.x && this.ball.x <= this.platform.x + 100)) {
      this.ballDirection.y = -this.ballDirection.y
    }
    // this.CableApp.cable.send({ to: 1, message: 'test message' })

  }
}
