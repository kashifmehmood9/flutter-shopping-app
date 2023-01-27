const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    validate: {
      validator: function (value) {
        return value.length > 1;
      },
      message: "Name should be longer than 1 character",
    },
  },
  email: {
    type: String,
    required: true,
    unique: true,
    trim: true,
    validator: function (value) {
      return validator.isEmail(value);
    },
    error: "{VALUE} is not a valid email",
  },
  password: {
    type: String,
    required: true,
  },
  address: {
    type: String,
    required: false,
    default: "",
  },
  type: {
    type: String,
    required: false,
    default: "user",
  },
});

const User = mongoose.model("User", userSchema);
module.exports = User;
