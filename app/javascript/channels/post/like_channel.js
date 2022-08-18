import consumer from "../consumer";

consumer.subscriptions.create("LikeChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    if (data.action == "create" && data.type == "Post") {
      console.log(data);
      const idPost = data.post_id;
      const getCountLike = $(`#count_like-${idPost}`);
      const oldCountLike = getCountLike.text().split(" ")[0];
      const newCountLike = parseInt(oldCountLike) + 1;

      console.log(getCountLike.text());

      getCountLike.html(`${newCountLike} Likes`);
    } else if (data.action == "destroy") {
    }
  },
});
