import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modals"
export default class extends Controller {
  connect() {}
  close(e){
    //Prevent default action
    e.preventDefault();
    const postId = document.getElementById("idpicker").innerHTML;
    window.location.href = '/posts/' +postId;
    //Remove from parent
    const modal = document.getElementById("modal");
    modal.innerHTML = "";
    //remove the src attribute
    modal.removeAttribute("src");

    //Remove complete atribute
    modal.removeAttribute("complete");

  }
}
