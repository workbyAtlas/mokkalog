import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter"
export default class extends Controller {
  static targets = ["filter1","filter2","filter3","filter4","filter5","filter6","filter7",
    "btn1","btn2","btn3","btn4","btn5","btn6","btn7"]
  connect() {
  }

  openFilter1(){

    for (let i = 1; i <= 7; i++) {
      const btn = this[`btn${i}Target`];
      const filter = this[`filter${i}Target`];

      btn.classList.toggle("is-active", i === 1);
      filter.classList.toggle("d-none", i !== 1);
    }
    
  }
  openFilter2(){

    for (let i = 1; i <= 7; i++) {
      const btn = this[`btn${i}Target`];
      const filter = this[`filter${i}Target`];

      btn.classList.toggle("is-active", i === 2);
      filter.classList.toggle("d-none", i !== 2);
    }
    
  }
  openFilter3(){

    for (let i = 1; i <= 7; i++) {
      const btn = this[`btn${i}Target`];
      const filter = this[`filter${i}Target`];

      btn.classList.toggle("is-active", i === 3);
      filter.classList.toggle("d-none", i !== 3);
    }
    
  }
  openFilter4(){

    for (let i = 1; i <= 7; i++) {
      const btn = this[`btn${i}Target`];
      const filter = this[`filter${i}Target`];

      btn.classList.toggle("is-active", i === 4);
      filter.classList.toggle("d-none", i !== 4);
    }
    
  }
  openFilter5(){

    for (let i = 1; i <= 7; i++) {
      const btn = this[`btn${i}Target`];
      const filter = this[`filter${i}Target`];

      btn.classList.toggle("is-active", i === 5);
      filter.classList.toggle("d-none", i !== 5);
    }
    
  }
  openFilter6(){

    for (let i = 1; i <= 7; i++) {
      const btn = this[`btn${i}Target`];
      const filter = this[`filter${i}Target`];

      btn.classList.toggle("is-active", i === 6);
      filter.classList.toggle("d-none", i !== 6);
    }
    
  }
  openFilter7(){

    for (let i = 1; i <= 7; i++) {
      const btn = this[`btn${i}Target`];
      const filter = this[`filter${i}Target`];

      btn.classList.toggle("is-active", i === 7);
      filter.classList.toggle("d-none", i !== 7);
    }
    
  }

}
