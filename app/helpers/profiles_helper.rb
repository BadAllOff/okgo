module ProfilesHelper

  # Helper wich returns profile photo of user if exists
  # if not, it returns stub image
  # img_size:  :micro, :small, :medium, :original
  def show_profile_img(user, img_size)
    if user.profile.photo?
      image_tag(user.profile.photo.url(img_size),
                class: "img-circle img-sm",
                alt: "#{user.profile.firstname} #{user.profile.lastname}",
                data: { toggle: 'tooltip', original_title: "#{user.profile.firstname} #{user.profile.lastname}" })
    else
      image_tag('medium_missing.png', class: "img-circle img-sm", alt: "#{user.profile.firstname} #{user.profile.lastname}")
    end
  end

end
