import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="country"
export default class extends Controller {
  change(event) {
    let country = event.target.selectedOptions[0].value;
    console.log(country);
    
  }
}
