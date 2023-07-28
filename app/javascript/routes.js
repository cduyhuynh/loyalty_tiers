import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import User from 'components/User';
import Orders from 'components/Orders';

export default (
  <Router>
    <Routes>
      <Route path='/users/:id' exact element=<User/> />
      <Route path='/users/:id/orders' exact element=<Orders/> />
    </Routes>
  </Router>
);