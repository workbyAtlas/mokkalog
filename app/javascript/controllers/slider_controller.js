import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {
  static targets = [ "slide" ]
  static values = { index: Number }

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
}
