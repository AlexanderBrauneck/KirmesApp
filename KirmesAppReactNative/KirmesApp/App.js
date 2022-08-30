import { HomeScreen } from "./HomeScreen";
import { UmsatzScreen } from "./UmsatzScreen";
import { Button, View, Text } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { AppStyle } from "./Styles";


const Stack = createNativeStackNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName="Home">
        <Stack.Screen 
          name="Kirmes App" 
          component={HomeScreen}
          options={({navigation}) => ({
            headerTitle: () => <Text style={AppStyle.TextFont}>Kirmes App</Text>,
            headerRight: () => <Button title="Umsätze ansehen" onPress={() => navigation.navigate('Umsätze')} />,
          })}
        />
        <Stack.Screen name="Umsätze" component={UmsatzScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}
