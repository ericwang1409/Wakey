const express = require('express'); //requires express module
const socket = require('socket.io'); //requires socket.io module
const fs = require('fs');
const app = express();
var IP = process.env.IP || "172.20.10.5"
var PORT = process.env.PORT || 3000;
const server = app.listen(PORT, IP); //tells to host server on localhost:3000


//Playing variables:
app.use(express.static('public')); //show static files in 'public' directory
console.log('Server is running');
const io = socket(server);

//Socket.io Connection------------------
io.on('connection', (socket) => {

    console.log("New socket connection: " + socket.id)

    socket.on('trumpet', () => {
        io.emit('trumpet');
    })

    socket.on('siren', () => {
        io.emit('siren');
    })

    socket.on('bruh', () => {
        io.emit('bruh');
    })

    socket.on('fart', () => {
        io.emit('fart');
    })
})





