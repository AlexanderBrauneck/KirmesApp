/**
 * Required External Modules and Interfaces
 */

 import express, { Request, Response } from "express";
 import * as QuittungService from "./quittung.service";
 import { Quittung, AllQuittung } from "./quittung.interface";

/**
 * Router Definition
 */

 export const quittungRouter = express.Router();

/**
 * Controller Definitions
 */

// GET items
quittungRouter.get("/", async (req: Request, res: Response) => {
    try {
      const quittung: AllQuittung = await QuittungService.findAll();
  
      res.status(200).send(quittung);
    } catch (e) {
      res.status(500).send(e.message);
    }
  });

// POST items
quittungRouter.post("/", async (req: Request, res: Response) => {
    try {
      const quittung: Quittung = req.body;
  
      const newQuittung = await QuittungService.create(quittung);
  

      res.status(201).json(newQuittung);
    } catch (e) {
      res.status(500).send(e.message);
    }
  });
