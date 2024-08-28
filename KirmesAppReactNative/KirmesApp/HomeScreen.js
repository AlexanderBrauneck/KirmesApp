import { Text, View, TouchableOpacity, Modal, Alert } from 'react-native';
import { KirmesItems } from './KirmesItems.json';
import { AppStyle, ItemViewStyle } from './Styles.js';
import { Feather, AntDesign } from '@expo/vector-icons'; 
import { useState } from 'react';
import CurrencyInput from 'react-native-currency-input';
import { documentDirectory, EncodingType, readAsStringAsync, writeAsStringAsync } from 'expo-file-system';

export function HomeScreen({ navigation }) {

  const [menuModalVisible, setMenuModalVisible] = useState(false);
  const [kirmesItems, setKirmesItems] = useState(KirmesItems);
  const [summe, setSumme] = useState(0);
  const [modalVisible, setModalVisible] = useState(false);
  const [gegeben, setGegeben] = useState();

  function addItem(item) {
    var newArray = [];
    for (let i = 0; i < kirmesItems.length; i++) {
      if (item.id == i) {
        item.anzahl++;
      }
      newArray = [...newArray,(kirmesItems[i])];
    }
    setKirmesItems(newArray);
    setSumme(summeBerechnen());
  }

  function removeItem(item) {
    if (item.anzahl > 0) {
      var newArray = [];
      for (let i = 0; i < kirmesItems.length; i++) {
        if (item.id == i) {
          item.anzahl--;
        }
        newArray = [...newArray,(kirmesItems[i])];
      }
      setKirmesItems(newArray);
      setSumme(summeBerechnen());
    } 
  }

  function summeBerechnen() {
    var newSumme = 0;
    for (let i = 0; i < kirmesItems.length; i++) {
      newSumme += kirmesItems[i].price*kirmesItems[i].anzahl;
    }
    return newSumme;
  }

  async function saveFile(items) {
    var umsatz = "\n";
    let fileUri = documentDirectory + "umsätze.txt";
    for (let i = 0; i < items.length; i++) {
      if (items[i].anzahl > 0) {
        umsatz += String(items[i].anzahl + " : " + items[i].name + " ,\n");
      }
    }
    try {
      let alteUmsätze = await readAsStringAsync(fileUri, { encoding: EncodingType.UTF8 });
      umsatz = alteUmsätze + "\n" + umsatz;
    } catch (error) {
      console.log("No such File");
    } finally {
        await writeAsStringAsync(fileUri, umsatz, { encoding: EncodingType.UTF8 });
    }
  }

  async function addcounters(item) {
    try {
      var counter = 0;
      let fileUri = documentDirectory + item.name;
      console.log(item.name);
      console.log(item.anzahl);
      if (item.anzahl > 0) {
        counter += item.anzahl;
      }
      let alterCounter = await readAsStringAsync(documentDirectory + item.name, { encoding: EncodingType.UTF8 });
      counter += parseInt(alterCounter);
    } catch (e) {
      console.warn(e);
    } finally {
      await writeAsStringAsync(documentDirectory + item.name, String(counter), { encoding: EncodingType.UTF8 });
    }
  }

  function zahlen() {
    var newArray = kirmesItems;
    let saveItems = kirmesItems;
    for (let i = 0; i < saveItems.length; i++) {
      addcounters(saveItems[i]);
    }
    saveFile(saveItems);
    for (let i = 0; i < newArray.length; i++) {
      newArray[i].anzahl = 0;
    }
    setKirmesItems(newArray);
    setSumme(0);
    setGegeben();
    setModalVisible(!modalVisible);
  }

  function onClose() {
    setMenuModalVisible(!menuModalVisible);
  }

  function reset() {
    var newArray = kirmesItems;
    for (let i = 0; i < newArray.length; i++) {
      newArray[i].anzahl = 0;
    }
    setKirmesItems(newArray);
    setSumme(summeBerechnen());
  }

  return (
    <View style = {AppStyle.container}>

{/* ITEMVIEW */}
        {kirmesItems && kirmesItems.map((item, i) => (
          <View key={i} style={{
            flexDirection: 'row',
            justifyContent: "space-between",
            justifyContent: 'center',
            alignItems: 'center',
            borderRadius: 20,
            padding: 5,
            width: '90%',
            height: 85 / kirmesItems.length + "%",
            backgroundColor: item.colorhex + "99"}}>

            <View style={ItemViewStyle.ItemViewOutline}>
              <TouchableOpacity style={ItemViewStyle.PlusMinusButton} onPress={() => removeItem(item)}>
                <Feather name="minus-circle" size={ItemViewStyle.PlusMinusButton.fontSize} color="black" />
              </TouchableOpacity>
              <View style={ItemViewStyle.MiddleView}>
                <View style={ItemViewStyle.NameAndPrice}>
                  <Text style={ItemViewStyle.TextFont}>
                    {item.name}
                  </Text>
                  <Text style={ItemViewStyle.TextFont}>
                    {(item.price/100).toFixed(2) + " €"}
                  </Text>
                </View>
                <View style={ItemViewStyle.AnzahlContainer}>
                  <Text style={ItemViewStyle.AnzahlFont}>
                    {item.anzahl}
                  </Text>
                </View>
              </View>
              <TouchableOpacity style={ItemViewStyle.PlusMinusButton} onPress={() => addItem(item)}>
                <Feather name="plus-circle" size={ItemViewStyle.PlusMinusButton.fontSize} color="black" />
              </TouchableOpacity>
              
            </View>
          </View>
        ))}

{/* BOTTOMBARVIEW */}
      <View style={AppStyle.BottomBar}>
        <View style={AppStyle.SummeView}>
          <Text style={AppStyle.TextFont}>
            { "Summe: " + (summe/100).toFixed(2) + " €"}
          </Text>
        </View>
        <TouchableOpacity style={AppStyle.ZahlenButton} onPress={() => reset()}>
          <Text style={AppStyle.TextFont}>
            Reset
          </Text>
        </TouchableOpacity>
        <TouchableOpacity style={AppStyle.ZahlenButton} onPress={() => setModalVisible(true)}>
          <Text style={AppStyle.TextFont}>
            Zahlen
          </Text>
        </TouchableOpacity>
      </View>

{/* POPUPVIEW */}
      <Modal
        animationType="slide"
        transparent={true}
        visible={modalVisible}
        onRequestClose={() => {
          Alert.alert('Modal has been closed.');
          setModalVisible(!modalVisible);
        }}>
        <View style={AppStyle.PopupViewContainer}>
          <View style={AppStyle.NumpadFixView}>
            <View style={AppStyle.FertigUndSchließen}>
              <TouchableOpacity 
                style={AppStyle.TextFont}
                onPress={zahlen}>
                <Text style={AppStyle.TextFont}>Fertig</Text>
              </TouchableOpacity>
              <TouchableOpacity
                style={AppStyle.closeButton}
                onPress={() => setModalVisible(!modalVisible)}>
                <AntDesign name="close" size={ItemViewStyle.PlusMinusButton.fontSize} color="black" />
              </TouchableOpacity>
            </View>
            <View style={AppStyle.Rückgeld}>
              <Text style={AppStyle.TextFont}>Gegeben: </Text>
              <View style={AppStyle.CurrencyInput}>
                <CurrencyInput 
                  style={AppStyle.TextFont}
                  placeholder="0.00 €"
                  value={gegeben}
                  onChangeValue={setGegeben}
                  suffix=" €"
                  separator='.'
                  precision={2}
                  autoFocus={true}/>
              </View>
            </View>
            <View style={AppStyle.Rückgeld}>
              <Text style={AppStyle.TextFont}>Rückgeld: </Text>
              <Text style={AppStyle.TextFont}>{(gegeben - (summe/100)).toFixed(2) + " €"}</Text>  
            </View>
          </View>
        </View>
      </Modal>
    </View>
  );
}
