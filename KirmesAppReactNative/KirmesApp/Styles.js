import { StyleSheet } from "react-native";
import { normalize } from "./FontSizer";

export const ItemViewStyle = StyleSheet.create({
  ItemViewOutline: {
    flexDirection: 'row',
    borderWidth: 5,
    borderRadius: 20,
    justifyContent: 'space-between',
    padding: 10,
    width: '98%',
    height: '95%'
  },
  PlusMinusButton: {
    justifyContent: 'center',
    alignItems: 'center',
    flexDirection: 'row',
    flex: 1,
    fontSize: normalize(20)
  },
  MiddleView: {
    justifyContent: "space-between",
    flexDirection: 'row',
    width: '70%'
  },
  NameAndPrice: {
    flexDirection: 'column',
    flex: 3,
    alignSelf: 'center'
  },
  TextFont: {
    fontSize: normalize(13),
    alignSelf: 'center'
  },
  AnzahlContainer: {
    flex: 1,
    flexDirection: 'row',
    alignSelf: 'center',
    justifyContent: 'flex-end',
    width: 29
  },
  AnzahlFont: {
    fontSize: normalize(17),
  },
})

export const ModalStyle = StyleSheet.create({
  modalContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
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
    width: '100%',
    height: 500,
  },
  FertigUndSchließen: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignSelf: 'center',
    width: '90%',
    height: '15%'
  },
  TextUndEingabe: {
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
    opacity: 0.8,
    borderRadius: 5,
    width: '60%',
    justifyContent: 'flex-end',
    paddingRight: 10,
    paddingLeft: 10,
    fontSize: normalize(13)
  },
  speichernUndAbbrechen: {
    paddingLeft: 10,
    flex: 1
  },
  ColorPickerUndButtons: {
    flexDirection: 'row',
    padding: 25
  },
  closeButton: {
    position: 'absolute',
    top: 10,
    right: 10,
  },
  cancelButton: {
    flex: 0.5,
    backgroundColor: 'gray',
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: 10,
    marginTop: 10,
  },
  cancelButtonText: {
    color: 'white',
    fontSize: normalize(13),
    fontWeight: 'bold',
  },
  saveButton: {
    flex: 0.5,
    backgroundColor: 'green',
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: 10,
    marginBottom: 10,
  },
  saveButtonText: {
    color: 'white',
    fontSize: normalize(13),
    fontWeight: 'bold',
  },
})

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
    confirmButton: {
      backgroundColor: 'green',
      padding: 10,
      borderRadius: 5,
    },
    confirmButtonText: {
      color: 'white',
      fontWeight: 'bold',
    },
    modalText: {
      fontSize: 18,
      marginBottom: 20,
    },
    button: {
      backgroundColor: 'lightblue',
      padding: 10,
      marginBottom: 10,
    },
    buttonText: {
      fontSize: 16,
      fontWeight: 'bold',
    },
    cancelButton: {
      backgroundColor: 'red',
      padding: 50,
      borderRadius: 5,
    },
    cancelButtonText: {
      color: 'white',
      fontWeight: 'bold',
    },
    deleteButtonBackground: {
      flex: 0.7,
      backgroundColor: 'red',
      borderRadius: 10,
      height: '40%',
      alignSelf: 'center',
      justifyContent: 'center',
      alignItems: 'center'
    },
    menuButton: {
      marginRight: 10,
    },
    overlay: {
      position: 'absolute',
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      alignItems: 'flex-end',
      justifyContent: 'flex-start',
    },
    menu: {
      backgroundColor: 'white',
      borderRadius: 5,
      marginTop: 70,
      marginRight: 10,
      padding: 10,
      elevation: 4,
    },
    menuItem: {
      padding: 10,
      borderBottomWidth: 1,
      borderBottomColor: 'lightgray',
    },
    overlayBackground: {
      flex: 1,
      backgroundColor: 'transparent',
    },
    HeaderView: {
      height: 50,
      width: 50,
      backgroundColor: "#000000"
    },
    BottomBar: {
      flexDirection: 'row',
      alignSelf: 'center',
      height: '10%',
      width: '85%',
      alignItems: 'center',
      justifyContent: 'space-between'
    },
    TextFont: {
      fontSize: normalize(13),
      alignSelf: 'center'
    },
    ZahlenButton: {
      borderRadius: 10,
      flex: 0.3,
      height: "70%",
      backgroundColor: '#918DEE',
      justifyContent: 'center'
    },
    SummeView: {
      borderRadius: 10,
      flex: 0.37,
      height: "70%",
      justifyContent: 'center'
    },
    
    
    
    UmsätzeScrollView: {
      width: '95%',
      alignSelf: 'center'
    }
  });

export const ColorPickerStyle = StyleSheet.create ({
  pickerContainer: {
    alignSelf: 'center',
    width: "70%",
    borderRadius: 50,
  },
  panelStyle: {
    borderRadius: 16,

    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,

    elevation: 5,
  },
  sliderStyle: {
    borderRadius: 20,
    marginTop: 20,

    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,

    elevation: 5,
  },

});
  