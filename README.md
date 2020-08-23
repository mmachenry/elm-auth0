Introduction
---

This project is a simple Elm example of using Auth0 to authenticate a user
login. I use the @auth0/auth0-spa-js Javascript library and handle the
authentication workflow in Javascript and pass the token in through ports
allong with loging and logout messages.

Inspiration
---

The authentication code comes largely from auth0's documentation. Particularly their [quick start guide for vanilla Javascript SPA](https://auth0.com/docs/quickstart/spa/vanillajs/01-login) as well as their [SPA SDK dodocs](https://auth0.com/docs/libraries/auth0-single-page-app-sdk)

In addition the project was built with Parcel following [their docs](https://parceljs.org/elm.html) Note that Parcel is very finicky unless your editor is behaving as it expects. Check out their documentation on [hot module reload](https://parceljs.org/hmr.html)
