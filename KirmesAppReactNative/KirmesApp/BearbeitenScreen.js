import { View, Text, TouchableOpacity, Modal, TextInput } from "react-native";
import { useState } from 'react';
import { AppStyle } from "./Styles";
import { KirmesItems } from './KirmesItems.json';
import { Ionicons } from '@expo/vector-icons';
import CurrencyInput from 'react-native-currency-input';
import { Snackbar } from 'react-native-paper';
import ItemModal from './ItemModal';

export function BearbeitenScreen({ navigation }) {

    const [kirmesItems, setKirmesItems] = useState(KirmesItems);
    const [modalVisible, setModalVisible] = useState(false);
    const [itemName, setItemName] = useState("");
    const [itemPreis, setItemPreis] = useState(0);
    const [itemId, setItemId] = useState(-1);

    const [snackVisible, setSnackVisible] = useState(false);
    const [snackText, setSnackText] = useState('');

    function closeModal() {
        setModalVisible(false);
    }

// TODO: Color erweitern

    function deleteItem(id) {
        
    }

    const handleSave = () => {
        console.log('Gespeichert: ', itemId, itemName, itemPreis);
        if (itemName != "") {
            //Item der Liste hinzufügen
            closeModal();
        } else {
            setSnackVisible(true);
            setSnackText("Das Item muss einen Namen haben");
        }
    };

    return (
        <View style = {AppStyle.container}>
    
{/* ITEMVIEW */}
            {kirmesItems && kirmesItems.map((item, i) => (
                <TouchableOpacity key={i} 
                    onPress={() => {
                        setItemName(item.name);
                        setItemId(item.id);
                        setItemPreis(item.price);
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
        
                    <View style={AppStyle.ItemViewOutline}>
                    <View style={AppStyle.NameAndPrice}>
                        <Text style={AppStyle.TextFont}>
                            {item.name}
                        </Text>
                        <Text style={AppStyle.TextFont}>
                            {(item.price/100).toFixed(2) + " €"}
                        </Text>
                        </View>
                        <TouchableOpacity onPress={deleteItem(itemId)} style={AppStyle.deleteButtonBackground}>
                            <View style={AppStyle.deleteButton}>
                                <Ionicons name="trash" size={24} color="black"/>
                            </View>
                        </TouchableOpacity>
                    </View>
                </TouchableOpacity>
            ))}

{/* BOTTOMBARVIEW */}
            <View style={AppStyle.BottomBar}>
                <TouchableOpacity 
                    style={AppStyle.ZahlenButton}
                    onPress={() => {
                        setItemName("");
                        setItemId(0);
                        setItemPreis(0);
                        setModalVisible(true);
                        }}>
                        <Text style={AppStyle.TextFont}>
                            Neues Item
                        </Text>
                </TouchableOpacity>
            </View>

{/* POPUPVIEW */}
            <Modal animationType="slide"
            visible={modalVisible}>
            <TouchableOpacity onPress={closeModal} style={AppStyle.closeButton}>
                <Ionicons name="close" size={24} color="black" />
            </TouchableOpacity>
            <View style={AppStyle.modalContainer}>
                <TextInput
                    style={AppStyle.input}
                    value={itemName}
                    onChangeText={setItemName}
                    autoFocus={true}
                />
                <View style={AppStyle.CurrencyInput}>
                    <CurrencyInput 
                        style={AppStyle.TextFont}
                        placeholder="0.00 €"
                        value={itemPreis}
                        onChangeValue={setItemPreis}
                        suffix=" €"
                        separator='.'
                        precision={2}/>
                </View>
                <TouchableOpacity onPress={handleSave} style={AppStyle.saveButton}>
                    <Text style={AppStyle.saveButtonText}>Speichern</Text>
                </TouchableOpacity>
                <TouchableOpacity onPress={closeModal} style={AppStyle.cancelButton}>
                    <Text style={AppStyle.cancelButtonText}>Abbrechen</Text>
                </TouchableOpacity>
            </View>
            <Snackbar
                visible={snackVisible} 
                onDismiss={() => setSnackVisible(false)}
                duration={5000}
                children={snackText}
            />
        </Modal>
        </View>
    );
}