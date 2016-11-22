export default {

  AVAILABLE_TEAMS_PATH: '/frontend/available_teams',
  SELECTEd_TEAMS_PATH: '/frontend/teams',

  availableTeams() {

    return fetch(this.AVAILABLE_TEAMS_PATH, {
      credentials: 'same-origin'
    }).then((response) => {
      return response.json();
    }).then((jsonData) => {
      return jsonData.data.map((entry) => {
        return {
          code: entry.id,
          name: entry.attributes.name
        };
      });
    });
  },

  selectedTeams() {

    return fetch(this.SELECTEd_TEAMS_PATH, {
      credentials: 'same-origin'
    }).then((response) => {
      return response.json();
    }).then((jsonData) => {
      return jsonData.data.map((entry) => {
        return {
          id: entry.id,
          code: entry.attributes.id,
          name: entry.attributes.name
        };
      });
    });
  }
}