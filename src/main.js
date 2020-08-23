import { Elm } from './Main.elm'
import { Auth0Client } from '@auth0/auth0-spa-js';

var app = Elm.Main.init({
    node: document.querySelector('main')
})

const auth0 = new Auth0Client({
    domain: 'dev-r7kutrj3.us.auth0.com',
    client_id: '7NcpuplNHbvQ2j9XncIxmK7UFM5ckGgV'
});

window.onload = async () => {
    console.log("onload")
    const isAuthenticated = await auth0.isAuthenticated()
    if (isAuthenticated) {
        console.log("authed")
        updateApp()
    } else {
        console.log("not authed")
        const query = window.location.search;
        if (query.includes("code=") && query.includes("state=")) {
            console.log("handler redirect")
            await auth0.handleRedirectCallback();
            updateApp()
            window.history.replaceState({}, document.title, "/");
        }
    }
}

const updateApp = async () => {
    console.log("updateApp")
    const isAuthenticated = await auth0.isAuthenticated();
    console.log("isAuthenticated",isAuthenticated)
    if (isAuthenticated) {
        const user = await auth0.getUser()
        const token = await auth0.getTokenSilently()
        console.log("user",user,"token",token)
        app.ports.updateUserAndToken.send(token)
        //app.ports.updateUserAndToken.send({user: user, token: token})
    }
}

app.ports.login.subscribe(async (b) => {
    console.log("login")
    await auth0.loginWithRedirect({
        redirect_uri: window.location.origin
    })
})

app.ports.logout.subscribe(async (b) => {
    auth0.logout({
        returnTo: window.location.origin
    })
})
