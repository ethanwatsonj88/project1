import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';
import $ from 'jquery';

export default function lobby_init(lobby) {
	ReactDOM.render(<Project1 />, lobby);
}

class Project1 extends React.Component {
	constructor(props) {
		super(props);

		this.state = {
		}
	}

	render() {
		return (
			<div>
				<a href="/game/demo">demo</a>
				{/* <%= form_for @ conn, "/game/demo", fn f -> %>
				<p>Enter player name: <%= text_input f, :p_name %></p>
				<p><%= submit "go to game" %></p>
				<% end % >*/}
			</div>
		);
	}
}

