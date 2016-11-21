import {observable} from 'mobx';

export default class TeamStore {

  @observable availableTeams = [];
  @observable selectedTeams = [];

  constructor() {
    var _this = this;

    fetch('/frontend/available_teams', {
      credentials: 'same-origin'
    }).then((response) => {
      return response.json();
    }).then((jsonData) => {
      jsonData.data.forEach((entry) => {
        let team = {
          code: entry.id,
          name: entry.attributes.name
        };
        console.log(team);
        _this.availableTeams.push(team);

      })
    });
  }

}