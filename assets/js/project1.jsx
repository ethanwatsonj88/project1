import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';
import $ from 'jquery';

export default function project1_init(root) {
	ReactDOM.render(<Project1 />, root);
}

class Project1 extends React.Component {
	constructor(props) {
		super(props);
	}

	render() {
		return (
			<div>
				<h1>Pokemon Showdown</h1>
				<div className="board">
					<div className="player2CurrCard">
						{this.renderCard()}
					</div>
					<div className="player1CurrCard">
						{this.renderCard()}
					</div>
					<div className="movesBox">
						{this.renderMove()}
					</div>
				</div>			
			</div>
		);
	}

	renderCard() {
		return (
			<Card />
		);
	}

	renderMove() {
		return (
			<Move />
		);
	}
}

function Card(props) {
	return (
		<div className="currCard">
			Pikachu
		</div>
	);
}

function Move(props) {
	return (
		<div className="move">
			Punch
		</div>
	);
}
