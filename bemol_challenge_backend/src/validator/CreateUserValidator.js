import { Joi } from "express-validation";

const userValidation = {
    body: Joi.object({ 
        name: Joi.string().required(),
        email: Joi.string().email().required(),
        password: Joi.string().required(),
        cep: Joi.number().required(),
        city: Joi.string().required(),
        state: Joi.string().required(),
        address: Joi.string().required(),
        number: Joi.number().required(),
        complement: Joi.string().required(),
    })
};

export { userValidation };