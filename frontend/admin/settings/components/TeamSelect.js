import {observable} from 'mobx';
import {observer} from 'mobx-react';
import React from 'react';

@observer
export default class TeamSelect extends React.Component {

  @observable value = '';

  render() {
    const teamStore = this.props.teamStore;
    return (
      <div id="teams-form" className="clearfix">

        <form className='form-inline' onSubmit={this.onSubmit.bind(this)}>

          <input value={this.value} list='available-teams-list' onChange={this.onChange.bind(this)}
                 className='form-control col-sm-2'/>
          <datalist id='available-teams-list'>
            {teamStore.availableTeams.map((team) => {
              return (<option key={team.code} value={team.name}/>)
            })}
          </datalist>
          &nbsp;&nbsp;&nbsp;
          <button type="submit" className="btn btn-primary">Team Hinzufügen</button>

        </form>
      </div>
    );
  }

  onChange(event) {
    this.value = event.target.value;
  }

  onSubmit(event) {
    event.preventDefault();
    this.props.store.selectTeam(this.value);
    this.value = '';
  }
}