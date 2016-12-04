import {observable, computed} from 'mobx';
import TeamService from './TeamService'

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