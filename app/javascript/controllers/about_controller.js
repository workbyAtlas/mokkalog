import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="about"
export default class extends Controller {
  static targets = ["btn1","btn2","btn3","btn4","tab1","tab2","tab3","tab4"]
  connect() {
  }

  openTab(tabNumber) {
    // Define an array of all button targets
    const buttonTargets = [this.btn1Target, this.btn2Target, this.btn3Target, this.btn4Target];
    // Define an array of all tab targets
    const tabTargets = [this.tab1Target, this.tab2Target, this.tab3Target, this.tab4Target];
    
    // Loop through all button and tab targets
    buttonTargets.forEach((btn, index) => {
      if (index === tabNumber - 1) {
        btn.classList.add("bs"); // Add 'is-active' to the selected button
        tabTargets[index].classList.remove("d-none"); // Show the selected tab
      } else {
        btn.classList.remove("bs"); // Remove 'is-active' from all other buttons
        tabTargets[index].classList.add("d-none"); // Hide all other tabs
      }
    });
  }

  openTab1(){
    this.openTab(1);
  }
  openTab2(){
    this.openTab(2);
  }
  openTab3(){
    this.openTab(3);
  }
  openTab4(){
    this.openTab(4);
  }

  strikeout(){
    event.target.style.textDecoration = "line-through";
  }


}
