const express = require("express");
const User = require("../models/user");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const auth = require("../middleware/auth");

const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
  try {
    console.log("attempting to sign up");
    const { name, email, password } = req.body;

    const existingUser = await User.findOne({ email });

    if (existingUser) {
      return res.status(400).json({ message: "User already exists" });
    }

    let hashedPassword = await bcrypt.hash(password, 10);
    let user = new User({
      name,
      email,
      password: hashedPassword,
    });

    user = await user.save();
    return res.status(200).json(user);
  } catch (exception) {
    console.log(exception);
    return res.status(500).json({ error: exception.message });
  }
});

authRouter.post("/api/signin", async (req, res) => {
  try {
    console.log("attempting to sign in");
    const { email, password } = req.body;
    const user = await User.findOne({ email });

    if (!user) {
      return res.status(400).json({ message: "User does not exist" });
    }
    const ismatch = await bcrypt.compare(password, user.password);
    if (!ismatch) {
      return res.status(400).json({
        message: "Incorrect password. Please enter correct password.",
      });
    }
    const token = jwt.sign({ id: user._id }, "passwordKey", { expiresIn: 600 });

    return res.status(200).json({ token, ...user._doc });
  } catch (exception) {
    console.log(exception);
    return res.status(500).json({ error: exception.message });
  }
});

authRouter.post("/api/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");

    if (!token) {
      return res.json({ message: "No token provided." });
    }

    const verified = jwt.verify(token, "passwordKey");
    if (!verified) {
      return res.json(false);
    }

    const user = await User.findById(verified.id);
    if (!user) {
      return res.json(false);
    }

    return res.json(true);
  } catch (exception) {
    console.log(exception);
    return res.status(500).json(false);
  }
});

authRouter.get("/api/users", auth, async (req, res) => {
  try {
    const users = await User.findById(req.user);
    return res.status(200).json({ ...users._doc, token: req.token });
  } catch (exception) {
    console.log(exception);
    return res.status(500).json({ error: exception.message });
  }
});

module.exports = authRouter;
