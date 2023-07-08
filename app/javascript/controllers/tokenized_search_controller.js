import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tokenized-search"
export default class extends Controller {
  static targets = ["fieldSelect", "operatorSelect", "valueInput", "tagsContainer"]

  connect() {
    this.preventFormSubmitOnEnter()
  }

  preventFormSubmitOnEnter() {
    this.valueInputTarget.addEventListener("keydown", event => {
      if (event.key === "Enter") {
        event.preventDefault()
        this.updateValue(event)
      }
    })
  }

  showDropdown() {
    this.fieldSelectTarget.classList.remove("d-none")
  }

  selectField(event) {
    this.operatorSelectTarget.classList.remove("d-none")
  }

  selectOperator(event) {
    this.valueInputTarget.classList.remove("d-none")
  }

  updateValue(event) {
    if (event.key === "Enter" && this.valueInputTarget.value) {
      this.createTag()
      this.resetForm()
    }
  }

  createTag() {
    const [selectedField, selectedOperator, inputValue] = [
      this.fieldSelectTarget,
      this.operatorSelectTarget,
      this.valueInputTarget
    ].map(target => target.querySelector("select")?.value || target.value)

    const tagElement = this.buildTagElement(selectedField, selectedOperator, inputValue)
    const hiddenInput = this.buildHiddenInput(selectedField, selectedOperator, inputValue)
    tagElement.querySelector(".delete").addEventListener("click", () => {
      tagElement.remove()
      hiddenInput.remove()
    })
    this.tagsContainerTarget.appendChild(tagElement)
    this.element.appendChild(hiddenInput)
  }

  buildTagElement(selectedField, selectedOperator, inputValue) {
    const tagText = `${selectedField}  ${selectedOperator}  ${inputValue}`

    const tagElement = document.createElement("span")
    tagElement.classList.add("tag" ,"m-2" , "bp")

    const tagContent = document.createElement("span")
    tagContent.textContent = tagText
    tagElement.appendChild(tagContent)

    const closeButton = document.createElement("button")
    closeButton.type = "button"
    closeButton.classList.add("delete")

    tagElement.appendChild(closeButton)
    return tagElement
  }

  buildHiddenInput(selectedField, selectedOperator, inputValue) {
    const tagHiddenText = `${selectedField}__|__${selectedOperator}__|__${inputValue}`
    const hiddenInput = document.createElement("input")
    hiddenInput.type = "hidden"
    hiddenInput.name = "search[]"
    hiddenInput.value = tagHiddenText
    return hiddenInput
  }

  resetForm() {
    this.fieldSelectTarget.querySelector("select").value = ""
    this.operatorSelectTarget.querySelector("select").value = ""
    this.valueInputTarget.value = ""

    this.fieldSelectTarget.classList.add("d-none")
    this.operatorSelectTarget.classList.add("d-none")
    this.valueInputTarget.classList.add("d-none")
  }
}

