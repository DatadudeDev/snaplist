const admin = require("firebase-admin/app");
admin.initializeApp();

const helloWorld = require("./hello_world.js");
exports.helloWorld = helloWorld.helloWorld;
const spotifyauth = require("./spotifyauth.js");
exports.spotifyauth = spotifyauth.spotifyauth;
