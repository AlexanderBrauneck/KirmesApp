import React, { useState } from 'react';
import { AppStyle } from "./Styles";
import { Ionicons } from '@expo/vector-icons';
import { View, Text, TouchableOpacity, Modal, TextInput } from 'react-native';
import CurrencyInput from 'react-native-currency-input';
import { Snackbar } from 'react-native-paper';

const ItemModal = ({ isVisible, onClose, name, id, price }) => {
    
    const [itemName, setItemName] = useState(name);
    const [itemPreis, setItemPreis] = useState(price);
    const [itemId, setItemId] = useState(id);

    const [snackVisible, setSnackVisible] = useState(false);
    const [snackText, setSnackText] = useState('');

    const handleSave = () => {
        console.log('Gespeichert: ', itemId);
        if (itemName != "") {
            //Item der Liste hinzufügen
        } else {
            setSnackVisible(true);
            setSnackText("Das Item muss einen Namen haben");
        }
        onClose(); // Schließe das Modal, nachdem die Daten gespeichert wurden
    };

    return (
        <Modal animationType="slide"
            visible={isVisible}>
            <TouchableOpacity onPress={onClose} style={AppStyle.closeButton}>
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
                <TouchableOpacity onPress={onClose} style={AppStyle.cancelButton}>
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
    );
};

export default ItemModal;