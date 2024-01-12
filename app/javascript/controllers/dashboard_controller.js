import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard"
export default class extends Controller {
  static targets = ["Main1","list1","Main2","list2","Main3","list3","menu"]
  connect() {
  }

    openMain(index) {
    for (let i = 1; i <= 3; i++) {
      const list = this[`list${i}Target`];
      const main = this[`Main${i}Target`];

      list.classList.toggle("bold", i === index);
      main.classList.toggle("d-none", i !== index);
    }
  }

  openMain1() {
  this.openMain(1);
  this.menuTarget.style.height='300px';
}
  openMain2() {
  this.openMain(2);
  this.menuTarget.style.height ='900px';
}
  openMain3() {
  this.openMain(3);
  this.menuTarget.style.height ='900px';
}
}
