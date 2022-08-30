import { View, Text } from "react-native";
import { useState, useEffect } from 'react';
import { ScrollView } from "react-native-gesture-handler";
import { documentDirectory, EncodingType, readAsStringAsync } from 'expo-file-system';
import { AppStyle } from "./Styles";
import { KirmesItems } from './KirmesItems.json';

export function UmsatzScreen({ navigation }) {

    const [umsätze, setUmsätze] = useState();
    const [gesamt, setGesamt] = useState();
    let fileUri = documentDirectory + "umsätze.txt";

    useEffect(() => {
        async function prepare() {
          var newGesamt = ""
          for (let i = 0; i < KirmesItems.length; i++) {
            let counterSource = documentDirectory + KirmesItems[i].name;
            try {
              let counter = await readAsStringAsync(counterSource, { encoding: EncodingType.UTF8 });
              newGesamt += (counter + " : " + KirmesItems[i].name + "\n");
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
    <ScrollView style={AppStyle.UmsätzeScrollView}>
      <Text style={AppStyle.TextFont}>Gesamt verkauft:</Text>
      <Text style={{alignSelf: 'center'}}>{gesamt}</Text>
      <Text style={AppStyle.TextFont}>Verkäufe im einzelnen:</Text>
      <Text style={{alignSelf: 'center'}}>{umsätze}</Text>
    </ScrollView>
  );
}