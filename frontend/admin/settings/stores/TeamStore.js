import {observable} from 'mobx';
import TeamService from './TeamService'

export default class TeamStore {

  @observable availableTeams = [];
  @observable selectedTeams = [];

  constructor() {
    this._fetchAvailableTeams();
    this._fetchSelectedTeams();
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