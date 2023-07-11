import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  //static targets = ["items"]
  change(event) {
    let clothing = event.target.selectedOptions[0].value
  }
}
