const express = require("express");
const mongoose = require("mongoose");
const adminRoute = require("./routes/admin");
const authRouter = require("./routes/auth");
const productRouter = require("./routes/product");

const app = express();
app.use(express.json());

app.use(authRouter);
app.use(adminRoute);
app.use(productRouter);

const PORT = 3000;
const IP = "localhost";
const DBURI =
  "mongodb+srv://kashifmehmood:UNsGNPajLCuDSoT9@cluster0.jn9mnr0.mongodb.net";

mongoose
  .connect(DBURI)
  .then(() => {
    console.log("Connected to MongoDB");
  })
  .catch((err) => {
    console.log(`Error from MongoDB: ${err}`);
  });

app.listen(PORT, IP ,() => {
  console.log(`Server running on http://$IP:${PORT}`);
});
