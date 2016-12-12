# Ability to get "HOME" bredcrumb
module Breadcrumbed
  extend ActiveSupport::Concern

  included do
    add_breadcrumb ('<i class="fa fa-home"></i>'.html_safe).concat(I18n.t('breadcrumbs.homepage')), :root_path
  end

end
