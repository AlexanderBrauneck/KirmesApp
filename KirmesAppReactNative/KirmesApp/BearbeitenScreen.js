import { View, Text, TouchableOpacity, Modal, TextInput } from "react-native";
import { useState } from 'react';
import { AppStyle } from "./Styles";
import { KirmesItems } from './KirmesItems.json';
import { Ionicons } from '@expo/vector-icons';
import ItemModal from './ItemModal';

export function BearbeitenScreen({ navigation }) {

    const [kirmesItems, setKirmesItems] = useState(KirmesItems);
    const [modalVisible, setModalVisible] = useState(false);
    const [itemName, setItemName] = useState();
    const [itemPreis, setItemPreis] = useState();
    const [itemId, setItemId] = useState();

    function toggleModal() {
        setModalVisible(!modalVisible);
    }

    function delItem(id) {
        //setKirmesItems(kirmesItems.filter(item => item.id != id));
        //Alert.alert("Aufgabe gelöscht");
        //closeDelModal();
    }

    function updateItem() {

    }

    function addItem() {
        setItemId(kirmesItems.length);
        if (itemName != "") {
            //Item der Liste hinzufügen
        } else {
            setSnackVisible(true);
            setSnackText("Das Item muss einen Namen haben");
        }
    }

// TODO: Color erweitern

    function handleSaveButton() {
        if(itemId == -1) {
            addItem();
        } else {
            updateItem();
        }
        setModalVisible(false);
        //console.log(kirmesItems);
    }

    function openModal(name, id, price) {
        //setItemName(name);
        //setItemId(id);
        //setItemPreis(price);
        toggleModal();
    }

    const renderItem = ({ item }) => {

    }

    return (
        <View style = {AppStyle.container}>
    
{/* ITEMVIEW */}
            {kirmesItems && kirmesItems.map((item, i) => (
                <TouchableOpacity key={i} 
                    onPress={openModal(item.name, item.id, item.price)}
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
                        <TouchableOpacity onPress={updateItem} style={AppStyle.deleteButtonBackground}>
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
                    onPress={openModal("", -1, 0)}>
                        <Text style={AppStyle.TextFont}>
                            Neues Item
                        </Text>
                </TouchableOpacity>
            </View>

{/* POPUPVIEW */}
            <ItemModal 
                isVisible={modalVisible} 
                onClose={toggleModal} 
                name={itemName}
                id={itemId}
                price={itemPreis}
            />
        </View>
    );
}