module UsersHelper

  def user_image(user)
    return image_tag(user.image), class: '' if user.image
    gravatar_for(user)
  end

  def gravatar_for(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.username, class: "ui-w-100 rounded-circl")
  end
end
