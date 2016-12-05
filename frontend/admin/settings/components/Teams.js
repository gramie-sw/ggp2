import {Component} from 'react';
import React from 'react';
import TeamSelect from './TeamSelect';
import TeamItem from './TeamItem'
import {observer} from 'mobx-react';

@observer
export default class Teams extends Component {

  render() {
    const teamStore = this.props.teamStore;
    return (
      <div>
        <TeamSelect teamStore={teamStore}/>

        <div className="row">
          {teamStore.selectedTeams.map((team) => {
            return (<div className="col-lg-3 col-md-4 col-sm-6 col-xs-12" key={team.id}>
              <TeamItem team={team} teamStore={teamStore}/>
            </div>)
          })}
        </div>
      </div>
    );
  }
}