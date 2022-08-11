import "express-async-errors";

import { AppError } from "./error/AppError.js";
import { ValidationError } from "express-validation";

import express from "express";
import cors from "cors";

import { router } from "./routes/index.js";

const PORT = 3000;

const app = express();
app.use(cors());

app.use(express.json());
app.use(router);

app.use((err, request, response, next) => {
  if (err instanceof AppError) {
    return response.status(err.statusCode).json({
      error: true,
      message: err.message,
    });
  }

  if (err instanceof ValidationError) {
    return response
      .status(err.statusCode)
      .json({ error: true, message: err});
  }

  return response.status(500).json({
    error: true,
    status: "error",
    message: `Internal server error - ${err.message}`,
  });
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
