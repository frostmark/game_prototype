import actionCable from 'actioncable'

const WEBSOCKET_HOST = process.env.NODE_ENV === 'production'
                         ? 'wss://<YOUR_SERVER_SITE>/cable'
                         : 'ws://localhost:3001/cable';

export default function serverClient(
  { onUpdate = () => {} } = {}
) {

  this.cable = actionCable.createConsumer(WEBSOCKET_HOST);
  this.channel;
  this.onUpdate = onUpdate;
  this.ballPosition = {
    x: 0,
    y: 0
  }

  this.platform = {
    position: {
      x: 0.5
    }
  }

  this.ball = {
    position: {
      x: 0,
      y: 0
    }
  }

  this.subscribe = () => {
    this.channel = this.cable.subscriptions.create(
      { channel: 'GameChannel' },
      {
        connected: function () {
          this.perform('foobar', { body: '234234234234234' });
        },
        disconnected: this.disconnected,
        received: this.received,
        rejected: this.rejected,
      }
    );
  };

  this.received = (data) => {
    this.platform.position.x = data.platform.position.x
    this.ball.position.x = data.ball.position.x
    this.ball.position.y = data.ball.position.y
  };

  this.disconnected = () => {
    console.warn(`Repair Tracking for ${id} was disconnected.`);
  };

  this.rejected = () => {
    console.warn('I was rejected! :(');
  };
}
