# frozen_string_literal: true

module UsersHelper
  def options_for_user_types
    if current_user.admin?
      options = [%w[Admin],
                 %w[Manager], %w[Employee]]
    elsif current_user.manager?
      options = [%w[Employee]]
    end
  end

  def display_avatar(user)
    # byebug
    if user.image?
      image_tag user.image.thumb.url, class: 'rounded-circle', width: '200', height: '200'
    else
      image_tag 'fallback/default.png', class: 'rounded-circle', width: '200', height: '200'
    end
  end

  def display_avatar_comment(user)
    # byebug
    if user.image?
      image_tag user.image.thumb.url, class: 'rounded-circle', width: '50', height: '50'
    else
      image_tag 'fallback/default.png', class: 'rounded-circle', width: '50', height: '50'
    end
  end
end
