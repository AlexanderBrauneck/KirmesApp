

/**
 * Required External Modules
 */

import express from "express";
import * as dotenv from "dotenv";
import { itemsRouter } from "./items/items.router";
import { quittungRouter } from "./quittung/quittung.router";

dotenv.config();


/**
 * App Variables
 */

 if (!process.env.PORT) {
    process.exit(1);
 }
 
 const PORT: number = parseInt(process.env.PORT as string, 10);
 
 const app = express();


/**
 *  App Configuration
 */

 app.use(express.json());
 app.use("/kirmes/items", itemsRouter);
 app.use("/kirmes/quittung", quittungRouter);

/**
 * Server Activation
 */

 app.listen(PORT, () => {
    console.log(`Listening on port ${PORT}`);
  });

  