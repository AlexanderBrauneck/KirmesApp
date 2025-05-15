import { Text } from "react-native";
import { useState, useCallback, useEffect } from 'react';
import { GestureHandlerRootView, ScrollView } from "react-native-gesture-handler";
import { documentDirectory, EncodingType, readAsStringAsync, getInfoAsync } from 'expo-file-system';
import { AppStyle } from "./Styles";
import { KirmesItems } from './KirmesItems.json';
import { useFocusEffect } from '@react-navigation/native';

export function UmsatzScreen({ navigation }) {

    const [umsätze, setUmsätze] = useState();
    const [gesamt, setGesamt] = useState();
    const [kirmesItems, setKirmesItems] = useState(KirmesItems);
    const fileUri = documentDirectory + "umsätze.txt";

    const fileUri2 = documentDirectory + 'KirmesItemsNew.json';

    useFocusEffect(
      useCallback(() => {
        const loadPersistedData = async () => {
          try {
            const fileInfo = await getInfoAsync(fileUri);
            if (fileInfo.exists) {
              const jsonString = await readAsStringAsync(fileUri);
              setUmsätze(await readAsStringAsync(fileUri, { encoding: EncodingType.UTF8 }));
            }
          } catch (error) {
            console.error('Fehler beim Laden der Umsätze:', error);
          }
          
          try {
            const fileInfo2 = await getInfoAsync(fileUri2);
            if (fileInfo2.exists) {
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

    useEffect(() => {
        async function prepare() {
          var newGesamt = ""
          for (let i = 0; i < kirmesItems.length; i++) {
            let counterSource = documentDirectory + kirmesItems[i].name;
            try {
              let counter = await readAsStringAsync(counterSource, { encoding: EncodingType.UTF8 });
              newGesamt += (counter + " : " + kirmesItems[i].name + "\n");
            } catch (e) {
              console.warn(e);
            }
          }
          setGesamt(newGesamt);
          try {
            setUmsätze(await readAsStringAsync(fileUri, { encoding: EncodingType.UTF8 }));
          } catch (e) {
            console.warn(e);
          }
        }
        prepare();
      }, []);

    return (
    <GestureHandlerRootView>
    <ScrollView style={AppStyle.UmsätzeScrollView}>
      <Text style={AppStyle.TextFont}>Gesamt verkauft:</Text>
      <Text style={{alignSelf: 'center'}}>{gesamt}</Text>
      <Text style={AppStyle.TextFont}>Verkäufe im einzelnen:</Text>
      <Text style={{alignSelf: 'center'}}>{umsätze}</Text>
    </ScrollView>
    </GestureHandlerRootView>
  );
}