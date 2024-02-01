import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="previews"
export default class extends Controller {
  static targets = ["input", "preview","color","text","text2","text3"];

  connect() {
    // controller connected
  }

  preview() {
    let input = this.inputTarget;
    let preview = this.previewTarget;
    let file = input.files[0];
    let reader = new FileReader();

    reader.onloadend = function () {
      // Set the background image style instead of src
      preview.style.backgroundImage = `linear-gradient(0deg,#00000088 30%, #ffffff44 100%), url('${reader.result}')`;
      preview.style.backgroundSize = 'cover';
    };

    if (file) {
      reader.readAsDataURL(file);
    } else {
      // Reset the background style if no file is selected
      preview.style.backgroundImage = 'none';
    }
  }

  color() {
    console.log("color");
    let text = this.textTarget;
    let text2 = this.text2Target;
    let text3 = this.text3Target;


    let color= this.colorTarget.querySelector('select');
    let selectedColor = color.value;
    console.log(selectedColor)
    text.style.color = selectedColor;
    text2.style.color = selectedColor;
    text3.style.color = selectedColor;


  }
}