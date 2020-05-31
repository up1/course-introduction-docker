const http = require('http')
const express = require('express')
const os = require('os');
const { createTerminus } = require('@godaddy/terminus')

const app = express()
const server = http.createServer(app)

function onSignal () {
  console.log('server is starting cleanup')
}

async function onHealthCheck () {
  // checks if the system is healthy, like the db connection is live
  // resolves, if health, rejects if not
}

createTerminus(server, {
  signal: 'SIGINT',
  healthChecks: { '/healthcheck': onHealthCheck },
  onSignal
})

server.listen(3000)

app.get('/', (req, res) => {
    const ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;
    const hostname = os.hostname();
    res.send(`Hello World in hostname=${hostname}`)
})