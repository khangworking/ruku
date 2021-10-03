import { Controller } from "@hotwired/stimulus";
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["insertPoint", "pagination"];

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
      this.loadMore();
    }
  }

  loadMore() {
    let link = this.paginationTarget.querySelector('a[rel="next"]');
    if (!link) {
      this.allowRequest = false;
      return;
    }
    Rails.ajax({
      url: link.href,
      dataType: "json",
      type: "GET",
      success: (response) => {
        this.insertPointTarget.insertAdjacentHTML(
          "beforebegin",
          response.entries
        );
        this.paginationTarget.innerHTML = response.pagination;
        this.allowRequest = true;
      },
    });
  }
}
