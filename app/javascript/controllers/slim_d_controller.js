import { Controller } from "@hotwired/stimulus"
import SlimSelect from 'slim-select'
// Connects to data-controller="slim-d"
export default class extends Controller {
connect() {
    // Initialize Slim Select
    this.select = new SlimSelect({
      select: this.element,
      events: {
        afterChange: (newVal) => {
          console.log(newVal);
        },
      },
    });
  }
}

