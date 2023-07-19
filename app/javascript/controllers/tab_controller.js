import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tab"
export default class extends Controller {
  static targets = ["tab1","tab2","tab3","btn1","btn2","btn3"]
  connect() {
  }
  openTab1(){

  this.btn1Target.classList.add("is-active")
  this.tab1Target.classList.remove("d-none")

  this.btn2Target.classList.remove("is-active")
  this.tab2Target.classList.add("d-none")

  this.btn3Target.classList.remove("is-active")
  this.tab3Target.classList.add("d-none")
    
  }
  openTab2(){

  this.btn2Target.classList.add("is-active")
  this.tab2Target.classList.remove("d-none")

  this.btn1Target.classList.remove("is-active")
  this.tab1Target.classList.add("d-none")

  this.btn3Target.classList.remove("is-active")
  this.tab3Target.classList.add("d-none")
    
  }
  openTab3(){

  this.btn3Target.classList.add("is-active")
  this.tab3Target.classList.remove("d-none")

  this.btn1Target.classList.remove("is-active")
  this.tab1Target.classList.add("d-none")

  this.btn2Target.classList.remove("is-active")
  this.tab2Target.classList.add("d-none")
    
  }
}
