import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="post"
export default class extends Controller {
  static targets = ["imageMain","image", "imageMain1","image1", "imageMain2","image2", "imageMain3","image3"]
  connect() {
    //this.imageShowTarget.classList.add("d-none")
  }
    showImage() {
    this.imageTarget.classList.add("image-select");
    this.imageMainTarget.classList.remove("d-none");

    this.imageMain1Target.classList.add("d-none"); 
    this.image1Target.classList.remove("image-select");

    this.image2Target.classList.remove("image-select");
    this.imageMain2Target.classList.add("d-none");

    this.image3Target.classList.remove("image-select");
    this.imageMain3Target.classList.add("d-none");



}

  showImage1() {
    this.image1Target.classList.add("image-select");
    this.imageMain1Target.classList.remove("d-none");

    this.imageMainTarget.classList.add("d-none"); 
    this.imageTarget.classList.remove("image-select");

    this.image2Target.classList.remove("image-select");
    this.imageMain2Target.classList.add("d-none");

    this.image3Target.classList.remove("image-select");
    this.imageMain3Target.classList.add("d-none");



}

  showImage2() {
    this.image2Target.classList.add("image-select");
    this.imageMain2Target.classList.remove("d-none");

    this.imageMainTarget.classList.add("d-none"); 
    this.imageTarget.classList.remove("image-select");

    this.image1Target.classList.remove("image-select");
    this.imageMain1Target.classList.add("d-none");

    this.image3Target.classList.remove("image-select");
    this.imageMain3Target.classList.add("d-none");



}
  showImage3() {
    this.image3Target.classList.add("image-select");
    this.imageMain3Target.classList.remove("d-none");

    this.imageMainTarget.classList.add("d-none"); 
    this.imageTarget.classList.remove("image-select");

    this.image1Target.classList.remove("image-select");
    this.imageMain1Target.classList.add("d-none");

    this.image2Target.classList.remove("image-select");
    this.imageMain2Target.classList.add("d-none");



}

}

