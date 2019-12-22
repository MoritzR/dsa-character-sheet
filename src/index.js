import './main.css';
import { Elm } from './Main.elm';
import * as serviceWorker from './serviceWorker';

const storedState = localStorage.getItem('character-sheet');
const startingState = storedState ? JSON.parse(storedState) : null;

console.log("Starting with stored character:")
console.log(storedState)

const app = Elm.Main.init({
  node: document.getElementById('root'),
  flags: startingState
});
app.ports.setStorage.subscribe(function(state) {
  localStorage.setItem('character-sheet', JSON.stringify(state));
});

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
