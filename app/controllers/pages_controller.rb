class PagesController < ApplicationController
  def show
    if valid_page?
      if user_signed_in?
        @groups = current_user.groups
        @images = Image.images_feed(current_user).order_by_created_at
      end
      render "pages/#{params[:page]}"
    else
      render "public/404.html", status: :not_found
    end
  end

  private
  def valid_page?
    File.exist? Pathname
      .new(Rails.root + "app/views/pages/#{params[:page]}.html.erb")
  end
end
