const express = require("express");
const User = require("../models/user");

const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
  try {
    console.log("attempting to sign up");
    const { name, email, password } = req.body;

    const existingUser = await User.findOne({ email });

    if (existingUser) {
      return res.status(400).json({ message: "User already exists" });
    }

    let user = new User({
      name,
      email,
      password,
    });

    user = await user.save();
    return res.status(200).json(user);
  } catch (exception) {
    console.log(exception);
    return res.status(500).json({ error: exception.message });
  }
});

module.exports = authRouter;