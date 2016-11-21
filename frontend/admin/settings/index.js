import React from 'react';
import ReactDOM from 'react-dom';

import TeamSelect from './components/TeamSelect'

import TeamsStore from './stores/TeamStore'


export default () => {

  let teamStore = new TeamsStore();

  ReactDOM.render(
    <TeamSelect teamStore={teamStore} />,
    document.getElementById('react-settings')
  );
}
