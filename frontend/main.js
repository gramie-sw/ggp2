import React from 'react';
import ReactDOM from 'react-dom';

window.blubi = () => {
  ReactDOM.render(
    <h1>React Settings</h1>,
    document.getElementById('react-settings'));
};

fetch('/available_teams', {
  credentials: 'same-origin'
}).then((response) => {
  return response.json();
}).then((jsonData) => {
  jsonData.data.forEach((entry) => {
    console.log(entry);
  })
});
