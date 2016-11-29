import React from 'react';
import ReactDOM from 'react-dom';
import Teams from './components/Teams'
import TeamsStore from './stores/TeamStore'


export default () => {

  let teamStore = new TeamsStore();

  ReactDOM.render(
    <Teams teamStore={teamStore} />,
    document.getElementById('react-settings')
  );
}
