class LikeChannel < ApplicationCable::Channel
    def subscribed
      stream_from "Like"
    end
  
    def unsubscribed
      stop_all_streams
    end
end
  