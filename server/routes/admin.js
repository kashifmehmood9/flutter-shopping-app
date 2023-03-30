const express = require('express')
const admin = require("../middleware/admin")
const Product = require('../models/product')
const adminRouter = express.Router()

// authRouter.post("/api/signup", async (req, res) => {
adminRouter.post("/admin/add-product", admin, async (req, res) => {
    try {
        const { name, description, images, quantity, price, category } = req.body
        let product = new Product({
            name,
            description,
            images,
            quantity,
            price,
            category
        })

        product = await product.save();

        return res.json(product);

    } catch (error) {
        return res.status(500).json({ message: error.message })
    }
})

adminRouter.get("/admin/get-products", admin, async (req, res) => {
    try {
        const products = await Product.find()
        return res.json(products)
    } catch (error) {
        return res.status(500).json({ message: error.message })
    }
})

adminRouter.delete("/admin/delete-product", admin, async (req, res) => {
    try {

    console.log("Deleting product with id: " + req.body.id)
        let product = await Product.findOneAndDelete(req.body.id)
        return res.json(product);
    } catch (error) {
    console.log("Error deleting product", error.message)
        return res.status(500).json({message: error.message})
    }
})

module.exports = adminRouter