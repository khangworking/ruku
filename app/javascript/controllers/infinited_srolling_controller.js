import { Controller } from "@hotwired/stimulus";
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["entries", "pagination"];
  connect() {
    this.allowRequest = true;
  }

  scroll() {
    let body = document.body,
      html = document.documentElement;
    let height = Math.max(
      body.scrollHeight,
      body.offsetHeight,
      html.scrollHeight,
      html.offsetHeight
    );
    if (
      window.scrollY >= height - window.innerHeight - 100 &&
      this.allowRequest
    ) {
      this.allowRequest = false;
      this.loadMore(() => (this.allowRequest = true));
    }
  }

  loadMore(cb) {
    let nextLink = this.paginationTarget.querySelector('a[rel="next"]');
    if (!nextLink) return;

    let url = nextLink.href;
    return Rails.ajax({
      url,
      dataType: "json",
      type: "GET",
      success: (response) => {
        this.entriesTarget.insertAdjacentHTML("beforeend", response.entries);
        this.paginationTarget.innerHTML = response.pagination;
        cb();
      },
    });
  }
}
