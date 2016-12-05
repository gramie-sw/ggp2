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

          <select value={this.value} onChange={this.onChange.bind(this)} className='form-control col-sm-2'>
            <option value="" disabled>Bitte wählen</option>
            {teamStore.selectableTeams.map((team) => {
              return (<option key={team.code} value={team.code}>{team.name}</option>)
            })}
          </select>
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
    this.props.teamStore.selectTeam(this.value);
    this.value = '';
  }
}