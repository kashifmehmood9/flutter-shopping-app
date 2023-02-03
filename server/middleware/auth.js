const jwt = require('jsonwebtoken');

const auth = async (req, res, next) => {
    try {
        const token = req.header("x-auth-token");
        if (!token) {
        return res.status(401).json({ message: "No token, authorization denied"})}


        const verified = jwt.verify(token, "passwordKey");
        if (!verified) {
        return res.status(401).json({ message: "Token invalid, authorization denied"})}


        req.user = verified.id;
        req.token = token;
                next();
    } catch (error) {
        return res.status(500).json({ error: exception.message });
    }
    }

    module.exports = auth;