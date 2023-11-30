import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter"
export default class extends Controller {
  static targets = ["filter1","filter2","filter3","filter4","filter5","filter6","filter7",
    "btn1","btn2","btn3","btn4","btn5","btn6","btn7"]
  connect() {
  }

openFilter(index) {
  for (let i = 1; i <= 7; i++) {
    const btn = this[`btn${i}Target`];
    const filter = this[`filter${i}Target`];

    if (btn && filter) {
      btn.classList.toggle("is-active", i === index);
      filter.classList.toggle("d-none", i !== index);
    }
  }
}

openFilter1() {
  this.openFilter(1);
}
openFilter2() {
  this.openFilter(2);
}
openFilter3() {
  this.openFilter(3);
}
openFilter4() {
  this.openFilter(4);
}
openFilter5() {
  this.openFilter(5);
}
openFilter6() {
  this.openFilter(6);
}
openFilter7() {
  this.openFilter(7);
}

}
