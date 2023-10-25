import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["btn-open","btn-close","dropdown"]
  connect() {
  }
  openDropdown(event){
    event.preventDefault();
    event.stopImmediatePropagation();
    this.dropdownTarget.classList.remove("d-none")


  }
  closeDropdown(event){
    event.preventDefault();
    event.stopImmediatePropagation();
    this.dropdownTarget.classList.add("d-none")

  }
}
