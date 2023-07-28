import axios from 'axios';

export default function(){
  const token = document.querySelector('[name=csrf-token]').content
  axios.defaults.headers.common['X-CSRF-TOKEN'] = token
}