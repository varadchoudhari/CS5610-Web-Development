import React from 'react';
import ReactDOM from 'react-dom';
import { Button } from 'reactstrap';

export default function run_demo(root) {
  ReactDOM.render(<Demo side={0}/>, root);
}

class Demo extends React.Component {
  constructor(props) {
    super(props);
    this.state = { side: props.side };
  }

  toggle(side) {
    var side = +!this.state.side;
    this.setState({side: side});
  }

  render() {
    var toggle = this.toggle.bind(this);
    return (
      <div className="row">
        <Side show={this.state.side == 0} toggle={toggle} />
        <div className="col">
          &nbsp;
        </div>
        <Side show={this.state.side == 1} toggle={toggle} />
      </div>
    );
  }
}

function Side(params) {
  if (params.show) {
    return (
      <div id="side-0" className="side col" onMouseOver={ () => params.toggle() }>
        <Button onClick={ () => alert("cheater") }>Click Me</Button>
      </div>
    );
  }
  else {
    return (
      <div id="side-0" className="side col">
        &nbsp;
      </div>
    );
  }
}

