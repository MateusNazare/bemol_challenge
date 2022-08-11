import { Router } from "express";
import { validate } from "express-validation";

import { userValidation } from "../validator/CreateUserValidator.js";
import UserController from "../controller/UserController.js";

const userRoutes = Router();

const userController = new UserController();

userRoutes.post("/", validate(userValidation), userController.create);
userRoutes.get("/", userController.getAll);

export { userRoutes };
