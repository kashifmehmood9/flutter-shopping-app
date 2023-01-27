const express = require('express');
const mongoose = require('mongoose');

const app = express();

app.use(express.json());
const authRouter = require('./routes/auth');
app.use(authRouter);


const PORT = 3000;
const IP = 'localhost';
const DBURI = 'mongodb+srv://kashifmehmood:UNsGNPajLCuDSoT9@cluster0.jn9mnr0.mongodb.net'

mongoose.connect(DBURI).then(() => {
    console.log('Connected to MongoDB');
}).catch((err) => {
    console.log(`Error from MongoDB: ${err}`);
});

app.listen(PORT, IP, () => {
    console.log(`Server running on http://${IP}:${PORT}`);
})