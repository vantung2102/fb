class CommentChannel < ApplicationCable::Channel
  def subscribed
    stream_from "Comment"
  end

  def unsubscribed
    stop_all_streams
  end
end
