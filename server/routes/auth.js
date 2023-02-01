    const express = require("express");
    const User = require("../models/user");
    const bcrypt = require("bcryptjs");

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


    authRouter.post('/api/signin', async (req, res) => {
      try {
        console.log("attempting to sign in");
        const { email, password } = req.body;
        const user = await User.findOne({ email });

        if (!user) {
        return res.status(400).json({ message: "User does not exist"})
        }
        const ismatch = await bcrypt.compare(password, user.password);
        if (!ismatch) {
        return res.status(400).json({ message: "Incorrect password. Please enter correct password." });
        }

        return res.status(200).json(user);
        }
        catch (exception) {
        console.log(exception);
        return res.status(500).json({ error: exception.message });
        }
        }
        );

    module.exports = authRouter;
