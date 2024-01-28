import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pagy"
export default class extends Controller {
  connect() {

  }
  scrollToTop() {

    window.scrollTo({
      top: 0,
      behavior: 'instant' // Optional: for smooth scrolling

    });
    
  }
}