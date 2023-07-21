import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {
  static targets = [ "slide" ]
  static values = { index: Number }

  connect() {
    //this.startAutoIncrement();
  }

  startAutoIncrement() {
    // Set an interval to call the `next` method every 5 seconds (5000 milliseconds)
    this.autoIncrementInterval = setInterval(() => {
      this.next();
    }, 5000);
  }

  next() {
    if (this.indexValue == 3){
      this.indexValue = 0
    }else{
      this.indexValue++
    }
  }

  previous() {
    if (this.indexValue == 0){
      this.indexValue = 3
    }else{
    this.indexValue--
  }

  }

  indexValueChanged() {
    this.showCurrentSlide()
  }

  showCurrentSlide() {
    this.slideTargets.forEach((element, index) => {
      element.hidden = index !== this.indexValue
    })
  }
  disconnect() {
    // Clear the interval when the controller is disconnected to stop the auto-increment
    clearInterval(this.autoIncrementInterval);
  }
}
