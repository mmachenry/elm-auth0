To start
---

Project was created following this tutorial for Elm and Parcel: https://benpaulhanna.com/building-an-elm-project-with-parcel.html

   npm init
   npm install --save parcel
   # Then edit some code

Then code was added using this tutorial for Auth0: https://auth0.com/docs/libraries/auth0-single-page-app-sdk#create-the-client

   npm install @auth0/auth0-spa-js
   # Then edit some code

    npm --version
    6.14.8
    npx parcel --version
    1.12.4
    elm --version # this is installed globally in /usr/local/bin though it might not be in use for this project
    0.19.1

Source maps are broken
---

Run the server with this command.

    npx parcel --no-source-maps src/index.html 

The server displays this error message.

    16 | //# sourceMappingURL=auth0-spa-js.production.esm.js.map
    17 | 
    Could not load existing sourcemap of "../node_modules/@auth0/auth0-spa-js/dist/auth0-spa-js.production.esm.js".

Most if not all references to this on line are bug reports from several
years ago. Not sure if it's ever been addressed. I found a work around to
remove source maps but that might not be the best idea.

Weird error output when importing invalid Javascript objects.
---

Run the server with this command.

    npx parcel --no-source-maps src/index.html 

Server runs fine with this output.

    Server running at http://localhost:1234 


Next go to src/main.js and introduce a typo in the import. Change the
import on line 2 by removing the 't' in Client to become

    import createAuth0Clien from '@auth0/auth0-spa-js';

The server's error output will display this and I have no idea what this
means. It's unrecoverable and will stop hot loading any changes until
rerun.

    Cannot read property 'type' of undefined
        at Bundler.createBundleTree (/home/mmachenry/src/elm-auth0/node_modules/parcel/src/Bundler.js:654:54)
        at Bundler.createBundleTree (/home/mmachenry/src/elm-auth0/node_modules/parcel/src/Bundler.js:721:12)
        at Bundler.bundle (/home/mmachenry/src/elm-auth0/node_modules/parcel/src/Bundler.js:298:14)
        at processTicksAndRejections (internal/process/task_queues.js:93:5)

It appears that hot loading is just broken.

Page hangs with blank output uppon adding Auth0 connection.
---

Run the server with this command.

    npx parcel --no-source-maps src/index.html 

Edit src/main.js to uncomment and reinstate this block of code.

    const auth0 = await createAuth0Client({
      domain: 'YOUR_DOMAIN',
      client_id: 'YOUR_CLIENT_ID'
    });

Notice the same weird "property 'type'" error from above, however... use
control-C to close the server and rerun it from the exact same code. Server
runs just fine, but the web app now displays a blank screen instead of the
proper Hello, World. Note that this behavior is the same when I have
changed the YOUR_DOMAIN and YOUR_CLIENT_ID to valid values from my Auth0
project.
