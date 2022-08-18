module ApplicationHelper
    include Pagy::Frontend
    
    def full_title(page_title = "")
        base_title = "Facebook"
        page_title.empty? ? base_title : "#{page_title} | #{base_title}"
    end

    def current_user?(user)
        user == current_user
    end

    def is_admin?(user)
        user.is_admin
    end
end
