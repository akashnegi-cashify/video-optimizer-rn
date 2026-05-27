/**
 * @format
 */

// Must be the very first import: replaces React Native's minimal URL polyfill (which has
// no `href` setter) with a full WHATWG URL impl. `@reglobe/lego-fetch` assigns to
// `requestUrl.href = ...` in its service-group rewriter; without this polyfill, that
// assignment silently no-ops and every request goes to `http://localhost/...`.
import 'react-native-url-polyfill/auto';
import 'react-native-gesture-handler';
import { enableScreens } from 'react-native-screens';
import { AppRegistry } from 'react-native';
import App from './App';
import RnLeafApp from './RnLeafApp';
import { name as appName } from './app.json';

enableScreens();

AppRegistry.registerComponent(appName, () => App);
AppRegistry.registerComponent('RnLeafApp', () => RnLeafApp);
