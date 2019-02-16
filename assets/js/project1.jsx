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

		// p1Deck Contains all cards, currCard is a pointer to that deck
		this.state = {
			me: "",
			opponent: "",
			p1Deck: [],
			p2Deck: [],
			p1CurrCard: "", 
			p2CurrCard: "",
		}
	}

	render() {
		return (
			<div>
				<h1>Pokemon Showdown</h1>
				<div className="board">
					<div className="player2CurrCard">
						{this.renderCard("blue_ghost")}
					</div>
					<div className="row">
						<div className="player1CurrCard">
							{this.renderCard("red_ghost")}
						</div>
						<div className="movesBox">
							{this.renderOptions()}
						</div>
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

	renderOptions() {
		return (
			<Options />
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

function Options(props) {
	return (
		<div className="options">
			<ul>
				<li><div className="option_button">Fight</div></li>
				<li><div className="option_button">Switch</div></li>
				<li><div className="option_button">Give Up</div></li>
			</ul>
		</div>
	);
}

function Fight(props) {
	return (
	<div></div>	
	);
}
