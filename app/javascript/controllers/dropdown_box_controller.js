import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown-box"
export default class extends Controller {
  static targets = ["dropdown1","dropdown2","dropdown3","dropdown4","dropdown5","dropdown6","dropdown7"]

  connect() {
  
  }

  openDropdown1(){
    this.dropdown1Target.classList.toggle("d-none")
  }
  openDropdown2(){
    this.dropdown2Target.classList.toggle("d-none")
  }
  openDropdown3(){
    this.dropdown3Target.classList.toggle("d-none")
  }
  openDropdown4(){
    this.dropdown4Target.classList.toggle("d-none")
  }
  openDropdown5(){
    this.dropdown5Target.classList.toggle("d-none")
  }
  openDropdown6(){
    this.dropdown5Target.classList.toggle("d-none")
  }
  openDropdown7(){
    this.dropdown5Target.classList.toggle("d-none")
  }
}
