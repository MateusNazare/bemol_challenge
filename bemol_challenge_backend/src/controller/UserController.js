import prismaClient from "../prisma/index.js";
import { AppError } from "../error/AppError.js";
import { hash } from "bcrypt";

class UserController {
  async create(request, response) {
    const {
      name,
      email,
      password,
      address,
      cep,
      complement,
      state,
      city,
      number,
    } = request.body;

    const userExists = await prismaClient.user.findUnique({
      where: { email },
    });

    if (userExists) {
      throw new AppError("User already exists!");
    }
    
    const passwordHash = await hash(password, 10);

    const user = await prismaClient.user.create({
      data: {
        name,
        email,
        password: passwordHash,
        address,
        cep,
        complement,
        state,
        city,
        number,
      },
    });

    delete user.password;

    return response.status(201).json(user);
  }

  async getAll(request, response) {
    const user = await prismaClient.user.findMany();

    return response.status(200).json(user);
  }
}

export default UserController;
