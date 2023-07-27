import React, { useState, useEffect } from 'react';
import {useParams} from 'react-router-dom';

import axios from 'axios';

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
    <p>Tier to be downgraded to next year: {user.downgraded_tier}</p>
    <p>The date of the downgrade (if eligible): {user.downgraded_date}</p>
    <p>Customer needs to spend this year to not to be downgraded next year: ${user.to_be_maintained_tier_remaining}</p>
    </div>
)};