import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';
import $ from 'jquery';

export default function project1_init(root, channel, client_p_name) {
	ReactDOM.render(<Project1 channel={channel} client_p_name={client_p_name} />, root);
}

class Project1 extends React.Component {
	constructor(props) {
		super(props);

		this.channel = props.channel;		

		this.client_p_name = props.client_p_name;

		this.channel
          .join()
          .receive("ok", this.got_view.bind(this))
          .receive("error", resp => { console.log("Unable to join", resp); });

		// p1Deck Contains all cards, currCard is a pointer to that deck
		this.state = {
			// DONE: this is wrong. fix --- works
			// this must be populate on startup? problems with rendering this empty
			p1_name: "",
			p2_name: "",
			p1_deck: [{img_src: "red_ghost", health: 0, moves: [{damage: 10, name: "fake"}]}],
			p2_deck: [{img_src: "blue_ghost", health: 0, moves: Array(4)}],
			p1_curr_card: 0, 
			p2_curr_card: 0,
			options_condition: "show_options",
		}
	}

	got_view(view) {
		console.log("new view", view);
		console.log(view.game.p1_deck[0].name)
		console.log(this.state)
		this.setState(view.game);
		console.log(this.state);
		console.log("curr player name is: " + this.client_p_name);
	}

	render() {
		let i_am_p1 = null;
		// if p1 is the current client player, then present that player at the bottom w option box
		if (this.client_p_name == this.state.p1_name) {
			i_am_p1 = true;
		}
		else {
			// i am player 2
			i_am_p1 = false;
		}
		// check if people win and stuff, or jst print the game
		if (this.state.condition == "justinwin") {
			return (
				<div>justin won!</div>
			);
		}	else if (this.state.condition == "ethanwin") {
			return (
				<div>ethan won!</div>
			);
		} else {
			return (
				<div>
					<h1>Pokemon Showdown</h1>
					<div className="board">
						<div className="p2_name">
							{ this.render_opp_name(i_am_p1) }
						</div>
						<div className="player2CurrCard">
							health: { this.render_opp_curr_card_health(i_am_p1) }
							{ this.render_opp_curr_card(i_am_p1) }
						</div>
						<div className="middle_board">
						</div>
						<div className="p1_name">
							{ this.render_my_name(i_am_p1) }
						</div>
						health: { this.render_my_curr_card_health(i_am_p1) }
						<div className="row">
							<div className="player1CurrCard">
								{ this.render_my_curr_card(i_am_p1) }
							</div>
							<div className="moves_box">
								{this.renderOptions(i_am_p1)}
							</div>
						</div>
					</div>			
				</div>
			);	
		}
	}
		
	render_my_curr_card(i_am_p1) {
			if (i_am_p1) {
			return this.renderCard(this.state.p1_deck[this.state.p1_curr_card].img_src)
		} else {
			return this.renderCard(this.state.p2_deck[this.state.p2_curr_card].img_src)
		}
	}

	render_my_curr_card_health(i_am_p1) {
		if (i_am_p1) {
			return this.state.p1_deck[this.state.p1_curr_card].health
		} else {
			return this.state.p2_deck[this.state.p2_curr_card].health
		}
	}

	render_my_name(i_am_p1) {
		if (i_am_p1) {
			return this.state.p1_name;
		} else {
			return this.state.p2_name;
		}
	}

	render_opp_curr_card(i_am_p1) {
		if (i_am_p1) {
			return this.renderCard(this.state.p2_deck[this.state.p2_curr_card].img_src)
		} else {
			return this.renderCard(this.state.p1_deck[this.state.p1_curr_card].img_src)
		}
	}

	render_opp_curr_card_health(i_am_p1) {
		if (i_am_p1) {
			return this.state.p2_deck[this.state.p2_curr_card].health;
		} else {
			return this.state.p1_deck[this.state.p1_curr_card].health;
		}
	}

	render_opp_name(i_am_p1) {
		if (i_am_p1) {
			return this.state.p2_name;
		} else {
			return this.state.p1_name;
		}
	}

	renderCard(card_name) {
		return (
			<Card card_name={card_name}/>
		);
	}

	renderOptions(i_am_p1) {
		let only_switch = this.state.condition == "justinswitch" || this.state.condition == "ethanswitch";

		if ((i_am_p1 && this.state.condition == "justinturn")
			|| (!i_am_p1 && this.state.condition == "ethanturn")) {
			// can move
			if (this.state.options_condition == "show_options") {
			return (
				<div className="options">
					{this.renderOption("fight", only_switch)}
					{this.renderOption("switch")}
					{this.renderOption("give up")}
				</div>
			);
			} else if (this.state.options_condition == "show_moves") {
				if (i_am_p1) {
					return (
						<div className="options">
							{this.renderMove(this.state.p1_deck[this.state.p1_curr_card].moves[0].name,
															this.state.p1_deck[this.state.p1_curr_card].moves[0].damage,
															i_am_p1)}
							{this.renderMove(this.state.p1_deck[this.state.p1_curr_card].moves[1].name,
															this.state.p1_deck[this.state.p1_curr_card].moves[1].damage,
															i_am_p1)}
							{this.renderMove(this.state.p1_deck[this.state.p1_curr_card].moves[2].name,
															this.state.p1_deck[this.state.p1_curr_card].moves[2].damage,
															i_am_p1)}
							{this.renderMove(this.state.p1_deck[this.state.p1_curr_card].moves[3].name,
															this.state.p1_deck[this.state.p1_curr_card].moves[3].damage,
															i_am_p1)}
						</div>
					);
				} else {
					return (
						<div className="options">
							{this.renderMove(this.state.p2_deck[this.state.p2_curr_card].moves[0].name,
															this.state.p2_deck[this.state.p2_curr_card].moves[0].damage,
															i_am_p1)}
							{this.renderMove(this.state.p2_deck[this.state.p2_curr_card].moves[1].name,
															this.state.p2_deck[this.state.p2_curr_card].moves[1].damage,
															i_am_p1)}
							{this.renderMove(this.state.p2_deck[this.state.p2_curr_card].moves[2].name,
															this.state.p2_deck[this.state.p2_curr_card].moves[2].damage,
															i_am_p1)}
							{this.renderMove(this.state.p2_deck[this.state.p2_curr_card].moves[3].name,
															this.state.p2_deck[this.state.p2_curr_card].moves[3].damage,
															i_am_p1)}
						</div>
					);
				}
			}
		} else {
			return (
				<div>Not your turn.</div>
			);
		}
	}

	renderOption(option_name, only_switch) {
		if (only_switch) {
			return (
				<Option
					onClick={() => true}
					option_name = {option_name}
				/>
			);
		} else {
			return (
				<Option
					onClick={() => this.handleOptionClick(option_name)}
					option_name = {option_name}
				/>
			);
		}
	}

	renderMove(move_name, move_damage, i_am_p1) {
		return (
			<Move
				onClick={() => this.handleMoveClick(move_name, move_damage, i_am_p1)}
				move_name = {move_name}
			/>
		);
	}

	handleOptionClick(option_name) {
		if (option_name == "fight") {
			let state1 = _.assign({}, this.state, {
				options_condition: "show_moves",
			});
			this.setState(state1);
		}
	}

	handleMoveClick(move_name, move_damage, i_am_p1) {
		console.log("iamp1 is " + i_am_p1)
		if (i_am_p1) {
			this.channel.push("fight", { player: this.state.p1_name, move_damage: move_damage })
					.receive("ok", this.got_view.bind(this));
		} else {
			this.channel.push("fight", { player: this.state.p2_name, move_damage: move_damage })
					.receive("ok", this.got_view.bind(this));
		}
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

function Option(props) {
	return (
		<div className="option_button" onClick={props.onClick}>{props.option_name}</div>
	);
}

function Move(props) {
	return (
		<div className="option_button" onClick={props.onClick}>{props.move_name}</div>
	);
}

function Fight(props) {
	return (
	<div></div>	
	);
}
