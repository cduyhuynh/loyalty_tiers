import React, { useState, useEffect } from 'react';
import {useParams} from 'react-router-dom';
import axios from 'axios';
import ProgressBar from './ProgressBar';

export default function(){
  const [user, setUser] = useState({});
  const userId = useParams();

  useEffect(() => {
    axios.get(`/api/users/${userId.id}`)
    .then(function(response){
      setUser({...response.data})
    })
  }, []);

  return(
    <div>
    <p>User {user.email}</p>
    <p>Current tier: {user.loyalty_tier}</p>
    <p>Start date of the tier calculation: {user.tier_calculation_start_date}</p>
    <p>Amount spent since that start date: ${user.total_spending}</p>
    <p>Amount that must be spent in order to reach the next tier: ${user.next_tier_remaining_amount}</p>
    <p>Progress:  
      {user.loyalty_tier} <div style={{width:'200px', display:'inline-block'}} ><ProgressBar progress={user.next_tier_progress}/> </div> {user.next_tier}
    </p>
    <p>If customer don't spend any more, next year they will be downgraded to: {user.downgraded_tier}</p>
    <p>The date of the downgrade (if eligible): {user.downgraded_date}</p>
    <p>To avoid being downgraded next year, customer needs to spend: ${user.to_be_maintained_tier_remaining} more</p>
    </div>
)};