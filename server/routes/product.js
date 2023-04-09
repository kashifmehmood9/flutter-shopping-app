const express = require('express')
const admin = require("../middleware/admin")
const {Product} = require('../models/product')
const productRouter = express.Router()
const auth = require('../middleware/auth')

// /api/products?category=essentials
productRouter.get("/api/products", auth, async (req, res) => {
    try {
        console.log("getting query for "+req.query.category);
        const products = await Product.find({category: req.query.category})
        return res.json(products)
    } catch (error) {
        return res.status(500).json({ message: error.message })
    }
})

productRouter.get("/api/products/search/:name", auth, async (req, res) => {
    try {
        console.log("getting query for "+req.params.name);
        const products = await Product.find({ name: { $regex: req.params.name}})
        console.log("Response for "+products);
        return res.json(products)
    } catch (error) {
        return res.status(500).json({ message: error.message })
    }
})
productRouter.post("/api/rate-product", auth, async (req, res) => {
  try {
    const { id, rating } = req.body;
    let product = await Product.findById(id);

    for (let i = 0; i < product.ratings.length; i++) {
      if (product.ratings[i].userId == req.user) {
        product.ratings.splice(i, 1);
        break;
      }
    }

    const ratingSchema = {
      userId: req.user,
      rating,
    };

    product.ratings.push(ratingSchema);
    product = await product.save();
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

productRouter.get("/api/deal-of-day", auth, async (req, res) => {
    try {
        let products = await Product.find({});
        products = products.sort((product1,product2) => {
            let suma = 0
            let sumb = 0

            product1.ratings.forEach((element) => { suma += element.rating})
            product2.ratings.forEach((element) => { sumb += element.rating})

            return suma < sumb ? 1 : -1;
        })

        return res.status(200).json({product: products[0]})

    }
    catch (e) {
    res.status(500).json({ error: e.message });
}
})


module.exports = productRouter