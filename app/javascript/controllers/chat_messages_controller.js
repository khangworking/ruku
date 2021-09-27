import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.allowRequest = true;
  }

  scroll() {
    if (
      this.element.scrollHeight <=
        this.element.offsetHeight + this.element.scrollTop * -1 + 200 &&
      this.allowRequest
    ) {
      this.allowRequest = false;
      console.log("lood more");
    }
  }
}
