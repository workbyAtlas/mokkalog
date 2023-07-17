import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tab"
export default class extends Controller {
  static targets = ["tab1","tab2","tab3","tab4","btn1","btn2","btn3","btn4"]
  connect() {
  }
  openTab1(){
    
  }
}
