import { HomeScreen } from "./HomeScreen";
import { UmsatzScreen } from "./UmsatzScreen";
import { NavigationContainer, useNavigation } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { BearbeitenScreen } from "./BearbeitenScreen";
import { TouchableOpacity, View, Text, Modal } from "react-native";
import { Ionicons } from '@expo/vector-icons';
import { useState } from "react";
import { AppStyle } from "./Styles";


const Stack = createNativeStackNavigator();

const MenuButton = ({ onPress }) => {
  return (
    <TouchableOpacity onPress={onPress} style={{ marginRight: 10 }}>
      <Ionicons name="ellipsis-vertical" size={24} color="black" />
    </TouchableOpacity>
  );
}

const MenuOverlay = ({ closeMenu }) => {
  const navigation = useNavigation();

  const goToSecondScreen = () => {
    navigation.navigate('Umsätze');
    closeMenu();
  };

  const goToThirdScreen = () => {
    navigation.navigate('Liste bearbeiten');
    closeMenu();
  };

  return (
    <View style={AppStyle.overlay}>
      <View style={AppStyle.menu}>
        <TouchableOpacity onPress={goToSecondScreen} style={AppStyle.menuItem}>
          <Text>Umsätze ansehen</Text>
        </TouchableOpacity>
        <TouchableOpacity onPress={goToThirdScreen} style={AppStyle.menuItem}>
          <Text>Liste bearbeiten</Text>
        </TouchableOpacity>
      </View>
      <TouchableOpacity onPress={closeMenu} style={AppStyle.overlayBackground} />
    </View>
  );
};

export default function App() {
  const [isMenuOpen, setIsMenuOpen] = useState(false);

  const onPressMenu = () => {
    setIsMenuOpen(!isMenuOpen);
  };

  return (
    <NavigationContainer>  
      <Stack.Navigator initialRouteName="Home">
        <Stack.Screen 
          name="Kirmes App" 
          component={HomeScreen} 
          options={({ navigation }) => ({
            headerRight: () => <MenuButton navigation={ navigation } onPress={onPressMenu} />,
          })}
        />
        <Stack.Screen name="Umsätze" component={UmsatzScreen} />
        <Stack.Screen name="Liste bearbeiten" component={BearbeitenScreen} />
      </Stack.Navigator>
      
      {isMenuOpen && <MenuOverlay closeMenu={onPressMenu} />}

    </NavigationContainer>
    
  );
}
