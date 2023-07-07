import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["items"]
  connect() {
    this.itemsTarget.hidden = false
  }

  showthebox(){
    this.hideboxTarget.hidden = false
  }
}
