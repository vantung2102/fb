module HomeHelper
    def gravatar_for(user, options = { size: 80 })
        gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
        size = options[:size]
        gravatar_url =
          "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.name, class: 'gravatar')
    end

    def avatar
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      size = scope && scope[:size] ? scope[:size] : 80
      "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    end
end
