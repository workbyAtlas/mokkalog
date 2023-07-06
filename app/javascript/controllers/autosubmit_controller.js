import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="autosubmit"
export default class extends Controller {
  static targets = ["submitbutton"]

  next(){
    this.index = (this.index + 1) % this.itemsTargets.length;
    this.updateActiveItem();
   }

  prev(){
    this.index = (this.index -1 + this.itemsTargets.length) % this.itemsTargets.length;
    this.updateActiveItem();
  }

  updateActiveItem(){
    this.itemsTargets.forEach((item,idx)=>{item.classList.toggle('active', idx === this.index);});
  }

  connect() {
    this.index = 0;
    this.updateActiveItem();

  }

  
}
