App.room = App.cable.subscriptions.create("RoomChannel", {

  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    $('<li>',{
        class: "hoge",

        // ここを修正します
        text: data["content"],
      }).appendTo("#add");
    };

    // Called when there's incoming data on the websocket for this channel
  },

  // ここも修正します
  speak: function(content, room_id) {
    return this.perform('speak', {content: content, room_id: room_id});
  }
});

$(function(){
  $(".button").on("click",function(){

    // ここを追加します
    var room_id = $(".room_id").val();
    var content = $(".chat-input").val();

    // ここを修正します
    App.room.speak(content, room_id);
    $(".chat-input").val("")
  });
});
