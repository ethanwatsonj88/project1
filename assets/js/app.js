// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"
import $ from "jquery";

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
import socket from "./socket";
import project1_init from "./project1";
import lobby_init from "./lobby";
//import hangman_init from "./hangman";
$(() => {
	let root = document.getElementById('root');
	let lobby = document.getElementById('lobby');
	if (root) {
		let channel = socket.channel("games:" + window.gameName, {});
		// if root, we can also grab player name and pass that to project1_init
		let client_p_name = $('meta[name=client_p_name]').attr("content");
		// We want to join in the react component.
		project1_init(root, channel, client_p_name);
	} else if (lobby) {
		lobby_init(lobby);
	}
});
