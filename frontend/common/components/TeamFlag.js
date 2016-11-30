import React from 'react';

export default (props) => {
  let flagTag;
  const teamCode = props.teamCode;
  const size = props.size;

  if (teamCode.startsWith('CLUB_')) {
    flagTag = (<i className={"club-logo club-logo-" + size + " fa fa-soccer-ball-o"}/>);
  } else {
    flagTag = (<image src="blank.gif" className={"flag flag-" + size + teamCode.toLowerCase()}/>);
  }

  return flagTag;
}