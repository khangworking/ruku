import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.allowRequest = true;
    document.addEventListener(
      "turbo:before-stream-render",
      (e) => {
        if (e.target.getAttribute("target") !== "new_messages") return;
        console.log(e);
      },
      true
    );
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
