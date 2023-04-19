const express = require("express");
const userRouter = express.Router();
const auth = require("../middleware/auth");
const User = require("../models/user");
const { Product } = require("../models/product");
const Order = require("../models/order");

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
            user.cart[i].product.quantity += 1
        }
        user = await user.save();
        return res.json(user);
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
});

userRouter.delete("/api/remove-from-cart/:id", auth, async (req, res) => {
    try {
        const { id } = req.params;
        console.log("remove product form cart " + id);
        const product = await Product.findById(id)

        let user = await User.findById(req.user);
        let quantity = product.quantity;

        const i = user.cart.findIndex(e => e.product._id.equals(product._id));
        if (user.cart[i].quantity <= 1) {
          console.log("removing from cart ")
          user.cart.splice(i, 1);
        } else {
            console.log("Product quantity greater than one")
            user.cart[i].quantity -= 1
        }
        user = await user.save();
        return res.json(user);
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
});

// save user address
userRouter.post("/api/save-user-address", auth, async (req, res) => {
  try {
    const { address } = req.body;
    let user = await User.findById(req.user);
    user.address = address;
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


// order product

userRouter.post("/api/order", auth, async (req, res) => {
    try {
        const { cart,totalPrice,address } = req.body;
        let products = [];

        for(let i = 0; i < cart.length; i++) {
            let product = await Product.findById(cart[i].product._id)
            console.log("1. Ordering "+product)
            if(product.quantity >= cart[i].quantity) {
                console.log("2. Ordering "+product)
                product.quantity -= cart[i].quantity
                products.push({product, quantity: cart[i].quantity})
                await product.save();
            } else {
                console.log("Out of stock product "+product.quantity)
                console.log("Out of stock cart "+cart[i].quantity)
                return res.status(400).json({message: `${product.name} is out of stock`});
            }
        }

        let user = await User.findById(req.user)
        user.carts = []
        user = await user.save()

         let order = new Order({
            products,
            address,
            totalPrice,
            userId: req.user,
            orderedAt: new Date().getTime()
         })

         order = await order.save()

        return res.json(order);
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
});

module.exports = userRouter;
