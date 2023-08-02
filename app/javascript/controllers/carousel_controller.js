import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="carousel"
export default class extends Controller {
  static targets = ["slide"];
  static values = { index: Number };

  connect() {
    this.startAutoIncrement();
  }

  startAutoIncrement() {
    this.resetAutoIncrementTimer(); // Start the initial timer
  }

  resetAutoIncrementTimer() {
    // Clear the existing interval, if any
    if (this.autoIncrementInterval) {
      clearInterval(this.autoIncrementInterval);
    }

    // Set a new interval to call the `next` method every 5 seconds (250000 milliseconds)
    this.autoIncrementInterval = setInterval(() => {
      this.next();
    }, 10000);
  }

  next() {
    if (this.indexValue == 2) {
      this.indexValue = 0;
    } else {
      this.indexValue++;
    }

    this.resetAutoIncrementTimer(); // Reset the timer after updating the indexValue
  }

  previous() {
    if (this.indexValue == 0) {
      this.indexValue = 2;
    } else {
      this.indexValue--;
    }

    this.resetAutoIncrementTimer(); // Reset the timer after updating the indexValue
  }

  indexValueChanged() {
    this.showCurrentSlide();
  }

  showCurrentSlide() {
    this.slideTargets.forEach((element, index) => {
      element.hidden = index !== this.indexValue;
    });
  }

  disconnect() {
    // Clear the interval when the controller is disconnected to stop the auto-increment
    clearInterval(this.autoIncrementInterval);
  }
}

