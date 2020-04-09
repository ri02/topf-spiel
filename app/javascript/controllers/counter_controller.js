import { Controller } from "stimulus";

export default class extends Controller {
   static targets = [ 'count', 'round', 'count_a', 'count_b', 'check'];
  connect() {
    setInterval(this.refresh, 5000);
  }

   refresh = () => {
     fetch( window.location.pathname, { headers: { accept: "application/json" } })
       .then(response => response.json())
       .then((data) => {
         this.countTarget.innerText = data.words_left.length;
         this.roundTarget.innerText = data.round;
         this.count_aTarget.innerText = data.counter_a;
         this.count_bTarget.innerText = data.counter_b;
         this.checkTarget.innerText = data.check;
       });
   }
}
