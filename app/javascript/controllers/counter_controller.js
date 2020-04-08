import { Controller } from "stimulus";

export default class extends Controller {
   static targets = [ 'count', 'round' ];

  connect() {
    setInterval(this.refresh, 5000);
  }

   refresh = () => {
     fetch( window.location.pathname, { headers: { accept: "application/json" } })
       .then(response => response.json())
       .then((data) => {
         this.countTarget.innerText = data.words_left.length;
         this.roundTarget.innerText = data.round;
       });
   }
}
