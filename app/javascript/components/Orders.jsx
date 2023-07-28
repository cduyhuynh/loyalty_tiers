import React, { useState, useEffect } from 'react';
import {useParams} from 'react-router-dom';
import axios from 'axios';

export default function(){
  const [orders, setOrders] = useState([]);
  const userId = useParams();

  useEffect(() => {
    axios.get(`/api/users/${userId.id}/orders`)
    .then(function(response){
      setOrders(response.data)
    })
  }, []);

  return(
    <div>
    {orders.length == 0 && 'No recent orders'}
    {orders.map((order) => {
      const createdAt = new Date(Math.floor(order.created_timestamp*1000));
      return (
        <div key={order.id}>
          Order: #{order.id}. Total: ${order.total}. Created at: {createdAt.toString()}
        </div>
      );
    })}
    </div>
)};