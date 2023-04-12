const express = require("express");
const userRouter = express.Router();
const auth = require("../middleware/auth");
const User = require("../models/user");
const { Product } = require("../models/product");

userRouter.post("/api/add-to-cart", auth, async (req, res) => {
    try {
        const { id } = req.body;
        console.log("adding to cart product " + id);
        const product = await Product.findById(id)

        let user = await User.findById(req.user);
        let quantity = product.quantity;

        const i = user.cart.findIndex(e => e.product._id.equals(product._id));
        if (i == -1) {
          console.log("Pushing")
          user.cart.push({ product, quantity: 1 });
        } else {
            console.log("Product found in array")
            user.cart[i].quantity += 1
        }
        user = await user.save();
        return res.json(user);
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
});

module.exports = userRouter;
