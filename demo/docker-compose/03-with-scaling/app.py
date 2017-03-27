from flask import Flask
from redis import Redis
import os
import socket

app = Flask(__name__)
redis = Redis(host=os.environ['REDIS_HOST'], port=6379)
host = socket.gethostname()

@app.route('/')
def hello():
   redis.incr('hits')
   return 'Host=%s =>Hello World! I have been seen %s times.\n' % (host, redis.get('hits'))

if __name__ == "__main__":
   app.run(host="0.0.0.0", debug=True)
