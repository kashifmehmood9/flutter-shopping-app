const express = require('express')
const { model } = require('mongoose')
const admin = require("../middleware/admin")
const Product = require('../models/product')
const adminRouter = express.Router()

// authRouter.post("/api/signup", async (req, res) => {
adminRouter.post("/admin/add-product", admin, async (req, res) => {
    try {
        const {name,description,images,quantity,price,category} = req.body
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
        
    }
} )

module.exports = adminRouter