import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["chatRoomItem"];

  connect() {
    this.activeItemClasses = ["bg-blue-400", "bg-opacity-20"];
    this.inactiveItemClasses = ["hover:bg-gray-100"];
  }

  removeActiveClasses() {
    this.chatRoomItemTargets.forEach((element) => {
      element.classList.remove(...this.activeItemClasses);
      element.classList.add(...this.inactiveItemClasses);
    });
  }

  addActiveClasses(target) {
    target.classList.remove(...this.inactiveItemClasses);
    target.classList.add(...this.activeItemClasses);
  }

  onChatRoomItemClicked(e) {
    this.removeActiveClasses();
    this.addActiveClasses(e.target);
  }
}
