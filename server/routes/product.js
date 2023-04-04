const express = require('express')
const admin = require("../middleware/admin")
const Product = require('../models/product')
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

productRouter.post('/api/rate-product', auth, async (req, res) => {
    try {
        console.log("Saving rating for "+req.body.id);

            Product.findOneAndUpdate(
                { userID: req.body.id },
                { $set: { ratings: { userId: req.body.id, rating: req.body.rating } } },
            )
            .exec()
            .then(function(product) {
                res.send(product);
            })
    } catch (error) {
        return res.status(500).json({ message: error.message })
    }
});

module.exports = productRouter