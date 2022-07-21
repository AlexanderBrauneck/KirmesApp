export interface BaseItem {
    name: string;
    price: number;
    colorhex: string;
  }
  
  export interface Item extends BaseItem {
    id: number;
  }