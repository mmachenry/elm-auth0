const { Elm } = require('./Main.elm');
import createAuth0Client from '@auth0/auth0-spa-js';

/*
const auth0 = await createAuth0Client({
  domain: 'YOUR_DOMAIN',
  client_id: 'YOUR_CLIENT_ID'
});
*/

Elm.Main.init({
  node: document.querySelector('main')
});
