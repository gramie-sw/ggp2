import {observable, computed, action} from 'mobx';
import TeamService from '../services/TeamService'

export default class TeamStore {

  @observable availableTeams = [];
  @observable selectedTeams = [];

  constructor() {
    this._fetchAvailableTeams();
    this._fetchSelectedTeams();
  }

  @computed get selectableTeams() {
    const selectedTeamCodes = this.selectedTeams.map((team) => {
      return team.code;
    });

    return this.availableTeams.filter((team) => {
      return !selectedTeamCodes.includes(team.code)
    });
  }

  @action deselectTeam(team) {
    const index = this.selectedTeams.indexOf(team);
    this.selectedTeams.splice(index, 1);
  }

  @action selectTeam(teamCode) {
    const selectedTeam = this.availableTeams.find((team) => {
      return team.code === teamCode;
    });

    this.selectedTeams.push(selectedTeam);
    this._sortSelectedTeams();
  }

  _sortSelectedTeams() {
    this.selectedTeams = this.selectedTeams.sort((team1, team2) => {
      if (team1.name < team2.name) {
        return -1;
      } else if (team2.name > team1.name) {
        return 1;
      } else {
        return 0;
      }
    })
  }

  _fetchAvailableTeams() {
    TeamService.availableTeams().then((teams) => {
      this.availableTeams.push(...teams);
    });
  }

  _fetchSelectedTeams() {
    TeamService.selectedTeams().then((teams) => {
      this.selectedTeams.push(...teams);
    });
  }
}