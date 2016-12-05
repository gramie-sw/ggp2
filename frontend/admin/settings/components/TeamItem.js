import {Component} from 'react';
import React from 'react';
import TeamFlag from '../../../common/components/TeamFlag'

export default (props) => {

  return (
    <div className="_team-box _emblem-with-team-name _team-name-24">
      <div className="pull-left">
        <TeamFlag teamCode={props.team.code} size={24}/>
        {props.team.name}
      </div>
      <div className="pull-right">
        <a href="" onClick={(event) => {
          event.preventDefault();
          props.teamStore.deselectTeam(props.team);
        }}>
          <i className="fa fa-trash-o"/>
        </a>
      </div>
    </div>
  )
};