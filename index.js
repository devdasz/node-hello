import dotenv from "dotenv";
dotenv.config(); // Load .env variables into process.env

import express from "express";
const app = express();

const PORT = process.env.PORT || 3000;
const MSG = process.env.CUSTOM_MSG || "No message received";

app.get("/", (req, res) => {
  res.send(`Hello World! Running on port ${PORT} | MSG: ${MSG}`);
});

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
