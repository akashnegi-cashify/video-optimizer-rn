/**
 * @format
 */

import { AppRegistry } from 'react-native';
import App from './App';
import RnLeafApp from './RnLeafApp';
import { name as appName } from './app.json';

AppRegistry.registerComponent(appName, () => App);
AppRegistry.registerComponent('RnLeafApp', () => RnLeafApp);
