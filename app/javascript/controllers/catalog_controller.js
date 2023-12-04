import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="catalog"
export default class extends Controller {
  static targets = ["filter","filterCount","filterBox"]

  connect() {window.filterCounter = 0;
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
  checkboxToggle(event){
    const checkbox = event.target;
    var previousCount = filterCounter;

    const isChecked = checkbox.checked;
    filterCounter += isChecked ? 1 : -1;
    this.filterCountTarget.textContent = filterCounter;

    if (filterCounter == 1){
      if(previousCount == 0){
        this.filterCountTarget.classList.toggle("d-none")
        this.filterBoxTarget.classList.toggle("filter-active")
      }
    }
    if (filterCounter == 0){
      if(previousCount == 1){
        this.filterCountTarget.classList.toggle("d-none")
        this.filterBoxTarget.classList.toggle("filter-active")
      }
    }
 


  }


}

