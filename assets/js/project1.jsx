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
						{this.renderCard("blue_ghost")}
					</div>
					<div className="player1CurrCard">
						{this.renderCard("red_ghost")}
					</div>
					<div className="movesBox">
						{this.renderMove()}
					</div>
				</div>			
			</div>
		);
	}

	renderCard(player) {
		return (
			<Card player={player}/>
		);
	}

	renderMove() {
		return (
			<Move />
		);
	}
}

function Card(props) {
	let card_name = "";
	let ghost = "blue_ghost";
	return (
		<div className="currCard">
			<img className="card_image" src={`/images/${props.player}.png`} alt="blue ghost"/>
			<br/>
			{props.player}
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
