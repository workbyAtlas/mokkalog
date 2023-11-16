import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="brand"
export default class extends Controller {
  static targets = ["productTab", "aboutTab","galleryTab", "productButton","aboutButton",
    "galleryButton","authorButton", "authorTab","analyticTab","analyticButton"]
  connect() {
  }
  openProduct(){
  this.productButtonTarget.classList.add("is-active-prime")
  this.productTabTarget.classList.remove("d-none")

  this.analyticButtonTarget.classList.remove("is-active-prime")
  this.analyticTabTarget.classList.add("d-none")

  this.aboutButtonTarget.classList.remove("is-active-prime")
  this.aboutTabTarget.classList.add("d-none")

  this.galleryButtonTarget.classList.remove("is-active-prime")
  this.galleryTabTarget.classList.add("d-none")

  this.authorButtonTarget.classList.remove("is-active-prime")
  this.authorTabTarget.classList.add("d-none")

  }

  openAbout(){
  this.aboutButtonTarget.classList.add("is-active-prime")
  this.aboutTabTarget.classList.remove("d-none")

  this.analyticButtonTarget.classList.remove("is-active-prime")
  this.analyticTabTarget.classList.add("d-none")

  this.productButtonTarget.classList.remove("is-active-prime")
  this.productTabTarget.classList.add("d-none")

  this.galleryButtonTarget.classList.remove("is-active-prime")
  this.galleryTabTarget.classList.add("d-none")

  this.authorButtonTarget.classList.remove("is-active-prime")
  this.authorTabTarget.classList.add("d-none")

  }

  openGallery(){
  this.galleryButtonTarget.classList.add("is-active-prime")
  this.galleryTabTarget.classList.remove("d-none")

  this.analyticButtonTarget.classList.remove("is-active-prime")
  this.analyticTabTarget.classList.add("d-none")

  this.productButtonTarget.classList.remove("is-active-prime")
  this.productTabTarget.classList.add("d-none")

  this.aboutButtonTarget.classList.remove("is-active-prime")
  this.aboutTabTarget.classList.add("d-none")

  this.authorButtonTarget.classList.remove("is-active-prime")
  this.authorTabTarget.classList.add("d-none")
  }

  openAuthor(){
  this.authorButtonTarget.classList.add("is-active-prime")
  this.authorTabTarget.classList.remove("d-none")

  this.analyticButtonTarget.classList.remove("is-active-prime")
  this.analyticTabTarget.classList.add("d-none")

  this.productButtonTarget.classList.remove("is-active-prime")
  this.productTabTarget.classList.add("d-none")

  this.aboutButtonTarget.classList.remove("is-active-prime")
  this.aboutTabTarget.classList.add("d-none")

  this.galleryButtonTarget.classList.remove("is-active-prime")
  this.galleryTabTarget.classList.add("d-none")

  }
  openAnalytic(){
  this.analyticButtonTarget.classList.add("is-active-prime")
  this.analyticTabTarget.classList.remove("d-none")

  this.productButtonTarget.classList.remove("is-active-prime")
  this.productTabTarget.classList.add("d-none")

  this.aboutButtonTarget.classList.remove("is-active-prime")
  this.aboutTabTarget.classList.add("d-none")

  this.galleryButtonTarget.classList.remove("is-active-prime")
  this.galleryTabTarget.classList.add("d-none")

  this.authorButtonTarget.classList.remove("is-active-prime")
  this.authorTabTarget.classList.add("d-none")

  }
}
