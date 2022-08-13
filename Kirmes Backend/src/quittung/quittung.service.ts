/**
 * Data Model Interfaces
 */

 import { Quittung, AllQuittung } from "./quittung.interface";
 import * as quittungData from './quittung.json';
 //import { saveAs } from 'file-saver'
 
     
/**
 * In-Memory Store
 */

 let allQuittung: AllQuittung = quittungData

/**
 * Service Methods
 */

 export const findAll = async (): Promise<AllQuittung> => Object.values(allQuittung);

 export const create = async (newQuittung: Quittung): Promise<Quittung> => {
    const id = new Date().valueOf();
  
    allQuittung[id] = {
      ...newQuittung,
    };

    //let blob = new Blob([JSON.stringify(allQuittung)], { type: 'application/json' })

    var fs = require('fs')
    fs.writeFileSync ("quittung.json", JSON.stringify(allQuittung), function(err) {
      if (err) {
        console.log("error");  
      }
    })

  
    return allQuittung[id];
  };
