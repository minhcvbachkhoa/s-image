class PagesController < ApplicationController
  def show
    if valid_page?
      @groups = current_user.groups if user_signed_in?
      render template: "pages/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private
  def valid_page?
    File.exist? Pathname
      .new(Rails.root + "app/views/pages/#{params[:page]}.html.erb")
  end
end
