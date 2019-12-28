import './main.css';
import { Elm } from './Main.elm';
import * as serviceWorker from './serviceWorker';

const defaultState = {
  name: "<Dein Charaktername>",
  baseStats: {
    mu: 12,
    kl: 10,
    int: 13,
    ch: 13,
    ff: 15,
    ge: 14,
    ko: 11,
    kk: 12
    },
  skills: {
    fly: 0,
    juggleries: 0,
    climb: 12,
    bodyControl: 12,
    showOfStrength: 0,
    ride: 0,
    swim: 0,
    composure: 2,
    sing: 0,
    acuity: 4,
    dance: 1,
    pickpocket: 4,
    hide: 8,
    quaff: 4,

    convert: 0,
    bewitch: 5,
    intimidate: 0,
    etiquette: 2,
    alleyLore: 9,
    insight: 7,
    persuade: 8,
    disguise: 2,
    willpower: 4,

    tracking: 0,
    shackle: 0,
    fishing: 0,
    navigation: 4,
    botany: 0,
    zoology: 0,
    survival: 0,

    gambling: 2,
    geography: 1,
    history: 1,
    godsAndCults: 2,
    warfare: 0,
    magic: 0,
    mechanics: 1,
    calculate: 6,
    legal: 5,
    sagasAndLegends: 3,
    spheres: 0,
    stars: 0,

    lockpicking: 9
    }
  }


const storedState = localStorage.getItem('character-sheet');
const parsedState = storedState ? JSON.parse(storedState) : {};

console.log("Starting with stored character:")
console.log(storedState)

const startingState = mergeDeep(defaultState, parsedState)

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




// helper functions for merging objects
function isObject(item) {
  return item && typeof item === 'object' && !Array.isArray(item);
}

function mergeDeep(target, source) {
  let output = Object.assign({}, target);
  if (isObject(target) && isObject(source)) {
    Object.keys(source).forEach(key => {
      if (isObject(source[key])) {
        if (!(key in target))
          Object.assign(output, { [key]: source[key] });
        else
          output[key] = mergeDeep(target[key], source[key]);
      } else {
        Object.assign(output, { [key]: source[key] });
      }
    });
  }
  return output;
}