const jwt = require("jsonwebtoken");
const user = require("../models/user");
const adminAuth = async (req, res, next) => {
    try {
        const token = req.header("x-auth-token");
        if (!token) {
            return res.status(401).json({ message: "No token found" });
        }

        const verified = jwt.verify(token, "passwordKey");

        if (!verified) {
            return res.status(401).json({ message: "User not authorized." });
        }

        const user = await User.findById(verified.id);

        if (user.type != "admin") {
            return res.status(401).json({ message: "Not an admin" });
        }

        req.user = verified.id;
        req.token = token;

        next();
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
};

module.exports = adminAuth
