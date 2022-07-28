/**
 * Data Model Interfaces
 */

 import { BaseItem, Item } from "./item.interface";
 import { Items } from "./items.interface";
 import * as itemsData from './items.json';

/**
 * In-Memory Store
 */

 let items: Items = itemsData
/* {

    1: {
      id: 1,
      name: "Bier",
      price: 250,
      colorhex: "#FF4500" //orangered
    },
    2: {
      id: 2,
      name: "Cola, Limo",
      price: 200,
      colorhex: "#ADFF2F" //greenyellow
    },
    3: {
      id: 3,
      name: "Wein",
      price: 199,
      colorhex: "#0000CD" //mediumblue
    },
    4: {
        id: 4,
        name: "Käse",
        price: 199,
        colorhex: "#A52A2A" //brown
      }
  };
*/
/**
 * Service Methods
 */

 export const findAll = async (): Promise<Item[]> => Object.values(items);

 export const find = async (id: number): Promise<Item> => items[id];

 // in items.json speichern
 export const create = async (newItem: BaseItem): Promise<Item> => {
    const id = new Date().valueOf();
  
    items[id] = {
      id,
      ...newItem,
    };
  
    return items[id];
  };

  // in items.json speichern
  export const update = async (id: number,itemUpdate: BaseItem): Promise<Item | null> => {
    const item = await find(id);
  
    if (!item) {
      return null;
    }
  
    items[id] = { id, ...itemUpdate };
  
    return items[id];
  };

  // in items.json speichern
  export const remove = async (id: number): Promise<null | void> => {
    const item = await find(id);
  
    if (!item) {
      return null;
    }
  
    delete items[id];
  };