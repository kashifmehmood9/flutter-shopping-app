
const express = require('express');
const authRouter = require('./routes/auth');
const app = express();
app.use(authRouter);
const PORT = 3000;
const IP = 'localhost';


app.get('/hello-world', (req, res) => {
    res.json({Hi:'Hello world'});
})

app.listen(PORT,IP,function () {
    console.log(`Server running at ${IP} ${PORT}`);
});