import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import User from 'components/User';

export default (
  <Router>
    <Routes>
      <Route path='/users/:id' exact element=<User/> />
    </Routes>
  </Router>
);