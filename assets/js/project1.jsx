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
		return <div>
			<h2>Project1 loaded.</h2>
		</div>;
	}	
}
