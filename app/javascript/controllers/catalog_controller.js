import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="catalog"
export default class extends Controller {
  static targets = ["btn1",, "btn2", "btn3", "btn4", "btn5", "btn6", "btn7", "btn8", "btn9", "btn10", 
    "btn11", "btn12", "btn13", "catalog1", "catalog2", "catalog3", "catalog4", "catalog5", "catalog6", "catalog7", "catalog8", 
    "catalog9", "catalog10", "catalog11", "catalog12", "catalog13", "filter"]

  connect() {
  }

  openCatalog(index) {
    for (let i = 1; i <= 13; i++) {
      const btn = this[`btn${i}Target`];
      const catalog = this[`catalog${i}Target`];

      btn.classList.toggle("home-active", i === index);
      catalog.classList.toggle("d-none", i !== index);
    }
  }

  filterToggle(){
    this.filterTarget.classList.toggle("is-active");
  }

  openCatalog1() {
    this.openCatalog(1);
  }

  openCatalog2() {
    this.openCatalog(2);
  }

  openCatalog3() {
    this.openCatalog(3);
  }

  openCatalog4() {
    this.openCatalog(4);
  }

  openCatalog5() {
    this.openCatalog(5);
  }

  openCatalog6() {
    this.openCatalog(6);
  }

  openCatalog7() {
    this.openCatalog(7);
  }

  openCatalog8() {
    this.openCatalog(8);
  }

  openCatalog9() {
    this.openCatalog(9);
  }

  openCatalog10() {
    this.openCatalog(10);
  }

  openCatalog11() {
    this.openCatalog(11);
  }

  openCatalog12() {
    this.openCatalog(12);
  }

  openCatalog13() {
    this.openCatalog(13);
  }
}

