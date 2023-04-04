const mongoose = require("mongoose");
const ratingSchema  = require("../models/rating");
const productSchema = mongoose.Schema({
    name: {
        type: String,
        requried: true,
        trim: true
    },
    description: {
        type: String,
        requried: true,
        trim: true
    },
    images: {
        type: [
            {
                type: String,
                required: true
            }
        ],
        required: true,
        trim: true
    },
    quantity: {
        type: Number,
        required: true
    },
    price: {
        type: Number,
        required: true
    },
    category: {
        type: String,
    },
    ratings: [ratingSchema]
});

const Product = mongoose.model("Product", productSchema)

module.exports = Product;