import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["items"]
  connect() {
    this.hideboxTarget.hidden = true
  }

  showthebox(){
    this.hideboxTarget.hidden = false
  }
}
