const express = require("express");
const userRouter = express.Router();
const auth = require("../middleware/auth");
const User = require("../models/user");
const { Product } = require("../models/product");
const Order = require("../models/order");

//userRouter.post("/api/add-to-cart", auth, async (req, res) => {
//  try {
//    const { id } = req.body;
//    const product = await Product.findById(id);
//    let user = await User.findById(req.user);
//
//    if (user.cart.length == 0) {
//      user.cart.push({ product, quantity: 1 });
//    } else {
//      let isProductFound = false;
//      for (let i = 0; i < user.cart.length; i++) {
//        if (user.cart[i].product._id.equals(product._id)) {
//          isProductFound = true;
//        }
//      }
//
//      if (isProductFound) {
//        let producttt = user.cart.find((productt) =>
//          productt.product._id.equals(product._id)
//        );
//        producttt.quantity += 1;
//      } else {
//        user.cart.push({ product, quantity: 1 });
//      }
//    }
//    user = await user.save();
//    res.json(user);
//  } catch (e) {
//    res.status(500).json({ error: e.message });
//  }
//});

userRouter.post("/api/add-to-cart", auth, async (req, res) => {
  try {
    const { id } = req.body;
    console.log("adding to cart product " + id);
    const product = await Product.findById(id);

    var user = await User.findById(req.user);
    let quantity = product.quantity;

    const i = user.cart.findIndex((e) => e.product._id.equals(product._id));
    if (i == -1) {
      console.log("Pushing");
      user.cart.push({ product, quantity: 1 });
    } else {
      console.log("Product found in array");
      user.cart[i].product.quantity += 1;
      console.log("QUANTITY added to cart product " + user.cart[i].quantity);
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
    const product = await Product.findById(id);

    let user = await User.findById(req.user);
    let quantity = product.quantity;

    const i = user.cart.findIndex((e) => e.product._id.equals(product._id));
    if (user.cart[i].quantity <= 1) {
      console.log("removing from cart ");
      user.cart.splice(i, 1);
    } else {
      console.log("Product quantity greater than one");
      user.cart[i].quantity -= 1;
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
    const { cart, totalPrice, address } = req.body;

    let products = [];

    for (let i = 0; i < cart.length; i++) {
      console.log("Cart product " + cart[i]);
      let object = JSON.parse(cart[i]);
      console.log("Object quantity " + object["quantity"]);

      let product = await Product.findOne({ where: { cart } });
      console.log("Ordered product " + product.quantity);
      if (product.quantity >= object["quantity"]) {
        product.quantity -= object["quantity"];
        products.push({ product, quantity: object["quantity"] });
        await product.save();
      } else {
        return res
          .status(400)
          .json({ msg: `${product.name} is out of stock!` });
      }
    }
    let user = await User.findById(req.user);
    user.carts = [];
    user = await user.save();

    let order = new Order({
      products,
      address,
      totalPrice,
      userId: req.user,
      orderedAt: new Date().getTime(),
    });

    order = await order.save();

    return res.json(order);
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
});

userRouter.get("/api/fetchMyOrders", auth, async (req, res) => {
  try {
    console.log("finding orders");
    const orders = await Order.find({ userId: req.user });
    console.log("Found orders" + orders);
    return res.json({ orders });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
});

module.exports = userRouter;
