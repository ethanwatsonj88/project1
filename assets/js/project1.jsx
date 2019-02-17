import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';
import $ from 'jquery';

export default function project1_init(root, channel) {
	ReactDOM.render(<Project1 channel={channel} />, root);
}

class Project1 extends React.Component {
	constructor(props) {
		super(props);

		this.channel = props.channel;		

		this.channel
          .join()
          .receive("ok", this.got_view.bind(this))
          .receive("error", resp => { console.log("Unable to join", resp); });

		// p1Deck Contains all cards, currCard is a pointer to that deck
		this.state = {
			// TODO: this is wrong. fix
			// this must be populate on startup? problems with rendering this empty
			p1_name: "",
			p2_name: "",
			p1_deck: [{img_src: "red_ghost"}],
			p2_deck: [{img_src: "blue_ghost"}],
			p1_curr_card: 0, 
			p2_curr_card: 0,
		}
	}

	got_view(view) {
		console.log("new view", view);
		console.log(view.game.p1_deck[0].name)
		console.log(this.state)
		this.setState(view.game);
	}

	render() {
		return (
			<div>
				<h1>Pokemon Showdown</h1>
				<div className="board">
					<div className="p2_name">
						{this.state.p2_name}
					</div>
					<div className="player2CurrCard">
						health: {this.state.p2_deck[this.state.p2_curr_card].health}
						{this.renderCard(this.state.p2_deck[this.state.p2_curr_card].img_src)}
					</div>
					<div className="middle_board">
					</div>
					<div className="p1_name">
						{this.state.p1_name}
					</div>
					health: {this.state.p1_deck[this.state.p1_curr_card].health}
					<div className="row">
						<div className="player1CurrCard">
							{this.renderCard(this.state.p1_deck[this.state.p1_curr_card].img_src)}
						</div>
						<div className="moves_box">
							{this.renderOptions()}
						</div>
					</div>
				</div>			
			</div>
		);
	}

	renderCard(card_name) {
		return (
			<Card card_name={card_name}/>
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
			<img className="card_image" src={`/images/${props.card_name}.png`} alt="blue ghost"/>
			<br/>
			{props.card_name}
		</div>
	);
}

function Options(props) {
	return (
		<div className="options">
			<div className="option_button">Fight</div>
			<div className="option_button">Switch</div>
			<div className="option_button">Give Up</div>
		</div>
	);
}

function Fight(props) {
	return (
	<div></div>	
	);
}
