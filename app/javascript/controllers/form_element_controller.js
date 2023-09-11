import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-element"
export default class extends Controller {
  static targets = ["remoteBtn"]

  connect() {
    //this.remoteBtn.hidden = true
  }

  autosubmit(event){
    //this.remoteBtnTarget.click()
    console.log(event.target.selectedOptions[0].value)
  }
}
