import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="post"
export default class extends Controller {
  static targets = ["imageMain1","image2", "imageMain2"]
  connect() {
    //this.imageShowTarget.classList.add("d-none")
  }

  showImage2(){
  this.image2Target.classList.add("image-select")
  
  this.imageMain1Target.classList.add("d-none")
  this.imageMain2Target.classList.remove("d-none")

}
}
