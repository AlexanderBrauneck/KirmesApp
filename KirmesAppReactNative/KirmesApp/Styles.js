import { StyleSheet } from "react-native";
import { normalize } from "./FontSizer";
import { KirmesItems } from './KirmesItems.json';

export const AppStyle = StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: '#FBEAD6',
      alignItems: 'center',
      justifyContent: 'center',
      justifyContent: "space-around",
      height: '100%',
      width: '100%',
    },
    ItemViewOutline: {
      flexDirection: 'row',
      borderWidth: 5,
      borderRadius: 20,
      justifyContent: 'space-between',
      padding: 10,
      width: '98%',
      height: '95%'
    },
    NameAndPrice: {
        flexDirection: 'column',
        alignSelf: 'center'
    },
    BottomBar: {
      flexDirection: 'row',
      alignSelf: 'center',
      height: '10%',
      width: '85%',
      alignItems: 'center',
      justifyContent: 'space-between'
    },
    PlusMinusButton: {
      alignSelf: 'center',
      fontSize: normalize(15)
    },
    TextFont: {
      fontSize: normalize(10),
      alignSelf: 'center'
    },
    ZahlenButton: {
      borderRadius: 5,
      backgroundColor: '#918DEE',
      width: '30%'
    },
    Anzahl: {
      alignSelf: 'center',
      justifyContent: 'space-around',
      fontSize: normalize(15)
    },
    MiddleView: {
      justifyContent: "space-between",
      flexDirection: 'row',
      width: '75%'
    },
    PopupViewContainer: {
      backgroundColor: '#F9DCBC',
      borderWidth: 2,
      borderRadius: 10,
      width: '95%',
      height: '100%',
      alignSelf: 'center'
    },
    NumpadFixView: {
      borderRadius: 10,
      width: '100%',
      height: 500,
      alignSelf: 'center'
    },
    FertigUndSchließen: {
      flexDirection: 'row',
      justifyContent: 'space-between',
      alignSelf: 'center',
      width: '90%',
      height: '15%'
    },
    Rückgeld: {
      flexDirection: 'row',
      justifyContent: 'space-between',
      width: '70%',
      height: '15%',
      alignSelf: 'center',
      borderBottomColor: 'black',
      borderBottomWidth: 1,
      padding: 5
    },
    CurrencyInput: {
      flexDirection: 'row',
      borderWidth: 2,
      opacity: 0.5,
      borderRadius: 5,
      width: '50%',
      justifyContent: 'flex-end',
      paddingRight: 10
    },
    UmsätzeScrollView: {
      width: '95%',
      alignSelf: 'center'
    }
  });
  