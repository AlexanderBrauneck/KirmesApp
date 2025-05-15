import { View, Text, TouchableOpacity, Modal, TextInput } from "react-native";
import { useState, useCallback } from 'react';
import { AppStyle, ColorPickerStyle, ItemViewStyle, ModalStyle } from "./Styles";
import { KirmesItems } from './KirmesItems.json';
import { Ionicons, AntDesign } from '@expo/vector-icons';
import CurrencyInput from 'react-native-currency-input';
import { Snackbar } from 'react-native-paper';
import { documentDirectory, EncodingType, readAsStringAsync, writeAsStringAsync, getInfoAsync } from 'expo-file-system';
import { useFocusEffect } from "@react-navigation/native";
import ColorPicker, { Panel1, Swatches, PreviewText, OpacitySlider, HueSlider, colorKit } from 'reanimated-color-picker';
import { useSharedValue } from "react-native-reanimated";

export function BearbeitenScreen({ navigation }) {

    const [kirmesItems, setKirmesItems] = useState(KirmesItems);
    const [modalVisible, setModalVisible] = useState(false);
    const [itemName, setItemName] = useState("");
    const [itemPreis, setItemPreis] = useState(0);
    const [preisAnzeige, setPreisAnzeige] = useState(0);
    const [itemId, setItemId] = useState(-1);
    const [itemColor, setItemColor] = useState(colorKit.randomRgbColor().hex());    

    const [snackVisible, setSnackVisible] = useState(false);
    const [snackText, setSnackText] = useState('');

    const fileUri2 = documentDirectory + 'KirmesItemsNew.json';

    useFocusEffect(
        useCallback(() => {
            const loadPersistedData = async () => {
            try {
                const fileInfo = await getInfoAsync(fileUri2);
                if (fileInfo.exists) {
                    const jsonString = await readAsStringAsync(fileUri2);
                    const savedItems = JSON.parse(jsonString);
                    setKirmesItems(savedItems);
                }
                } catch (error) {
                    console.error('Fehler beim Laden der persistierten Daten:', error);
                }
            };
            loadPersistedData();
        }, [])
    );

    function closeModal() {
        setModalVisible(false);
    }


// TODO: Color erweitern

    function deleteItem(id) {
        var newArray = [];
        for (let i = 0; i < kirmesItems.length; i++) {
            if (kirmesItems[i].id == id) {
                
            } else {
                newArray = [...newArray,
                    {
                        "anzahl": 0,
                        "colorhex": (kirmesItems[i].colorhex),
                        "id": (i),
                        "name": (kirmesItems[i].name),
                        "price": (kirmesItems[i].price)
                    }];
            }
        }
        setKirmesItems(newArray);
        saveArrayToJsonFile(newArray);
    }

    const handleSave = () => {
        var newArray = [];
        var found = false;
        //BUG: beim neu starten der App kommt es evtl zu id Dopplungen
        if (itemName != "") {
            for (let i = 0; i < kirmesItems.length; i++) {
                if (kirmesItems[i].id == itemId) {
                    newArray = [...newArray,
                        {
                            "anzahl": 0, 
                            "colorhex": (itemColor), 
                            "id": (i), 
                            "name": (itemName),
                            "price": ((preisAnzeige*100).toFixed(0))
                        }];
                    found = true;
                } else {
                    newArray = [...newArray,(kirmesItems[i])];
                }
            }
            if (!found) {
                newArray = [...newArray,
                    {
                        "anzahl": 0, 
                        "colorhex": (itemColor),
                        "id": (kirmesItems.length),
                        "name": (itemName),
                        "price": ((preisAnzeige*100).toFixed(0))
                    }];
            }
            setKirmesItems(newArray);
            saveArrayToJsonFile(newArray);
            closeModal();
        } else {
            setSnackVisible(true);
            setSnackText("Das Item muss einen Namen haben");
        }
    };

    async function saveArrayToJsonFile(jsArray) {
        try {
            const fileUri = documentDirectory + "KirmesItemsNew.json";
            await writeAsStringAsync(fileUri, JSON.stringify(jsArray), {
                encoding: EncodingType.UTF8,
            });
            console.log('Datei erfolgreich gespeichert!');
        } catch (error) {
            console.error('Fehler beim Speichern der Datei:', error);
        }
    };

    return (
        <View style = {AppStyle.container}>
    
{/* ITEMVIEW */}
            {kirmesItems && kirmesItems.map((item, i) => (
                <TouchableOpacity key={i} 
                    onPress={() => {
                        setItemColor(item.colorhex);
                        setItemName(item.name);
                        setItemId(item.id);
                        setItemPreis(item.price);
                        setPreisAnzeige(item.price/100);
                        
                        setModalVisible(true);
                        }}
                    style={{
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
                    <View style={ItemViewStyle.NameAndPrice}>
                        <Text style={ItemViewStyle.TextFont}>
                            {item.name}
                        </Text>
                        <Text style={ItemViewStyle.TextFont}>
                            {(item.price/100).toFixed(2) + " €"}
                        </Text>
                        </View>
                        <TouchableOpacity onPress={() => deleteItem(item.id)} style={AppStyle.deleteButtonBackground}>
                            <Ionicons name="trash" size={30} color="black"/>
                        </TouchableOpacity>
                    </View>
                </TouchableOpacity>
            ))}

{/* BOTTOMBARVIEW */}
            <View style={AppStyle.BottomBar}>
                <TouchableOpacity 
                    style={AppStyle.ZahlenButton}
                    onPress={() => {
                        setItemColor(colorKit.randomRgbColor().hex());
                        setItemName("");
                        setItemId(-1);
                        setItemPreis(0);
                        setPreisAnzeige(itemPreis/100);
                        
                        setModalVisible(true);
                        }}>
                        <Text style={AppStyle.TextFont}>
                            Neues Item
                        </Text>
                </TouchableOpacity>
            </View>

{/* POPUPVIEW */}
            <Modal 
                animationType="slide"
                transparent={true}
                visible={modalVisible}>
                <View style={ModalStyle.PopupViewContainer}>
                    <View style={ModalStyle.NumpadFixView}>
                        <View style={ModalStyle.FertigUndSchließen}>
                            <TouchableOpacity onPress={closeModal} style={ModalStyle.closeButton}>
                                <AntDesign name="close" size={ItemViewStyle.PlusMinusButton.fontSize} color="black" />
                            </TouchableOpacity>
                        </View>
                        <View style={ModalStyle.TextUndEingabe}>
                            <Text style={AppStyle.TextFont}>Name:</Text>
                            <TextInput
                                style={ModalStyle.CurrencyInput}
                                value={itemName}
                                onChangeText={setItemName}
                                autoFocus={true}
                            />
                        </View>
                        <View style={ModalStyle.TextUndEingabe}>
                            <Text style={AppStyle.TextFont}>Preis:</Text>
                            <View style={ModalStyle.CurrencyInput}>
                                <CurrencyInput
                                    style={AppStyle.TextFont}
                                    placeholder="0.00 €"
                                    value={preisAnzeige}
                                    onChangeValue={setPreisAnzeige}
                                    suffix=" €"
                                    separator='.'
                                    precision={2}/>
                            </View>
                        </View>
                        <View style={ModalStyle.ColorPickerUndButtons}>
                            <ColorPicker
                                style={ColorPickerStyle.pickerContainer}
                                value={(itemColor)}
                                sliderThickness={35}
                                thumbSize={35}
                                thumbShape='circle'
                                onChange={((color) => {
                                    setItemColor(color.hex);
                                })}
                                boundedThumb>
                                <Panel1 style={ColorPickerStyle.panelStyle} />
                                <HueSlider style={ColorPickerStyle.sliderStyle} />
                            </ColorPicker>
                            <View style={ModalStyle.speichernUndAbbrechen}>
                                <TouchableOpacity onPress={handleSave} style={ModalStyle.saveButton}>
                                    <Text style={ModalStyle.saveButtonText}>Speichern</Text>
                                </TouchableOpacity>
                                <TouchableOpacity onPress={closeModal} style={ModalStyle.cancelButton}>
                                    <Text style={ModalStyle.cancelButtonText}>Abbrechen</Text>
                                </TouchableOpacity>
                            </View>
                        </View>
                        <Snackbar
                            visible={snackVisible} 
                            onDismiss={() => setSnackVisible(false)}
                            duration={5000}
                            children={snackText}
                        />
                    </View>
                </View>
            </Modal>
        </View>
    );
}