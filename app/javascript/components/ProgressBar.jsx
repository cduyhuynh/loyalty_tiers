import React from 'react';

export default function({progress}){
  const containerStyles = {
    display: 'inline-block',
    height: 20,
    width: '100%',
    backgroundColor: "#e0e0de",
    borderRadius: 25,
  }

  const fillerStyles = {
    height: '100%',
    width: `${progress}%`,
    backgroundColor: '#CC5500',
    textAlign: 'center',
    borderRadius: 25,
    display: 'inline-block',
  }

  const labelStyles = {
    padding: 5,
    color: 'white',
    fontWeight: 'bold'
  }

  return (
    <div style={containerStyles}>
      <span style={fillerStyles}>
        <span style={labelStyles}>{`${progress}%`}</span>
      </span>
    </div>
  );
}