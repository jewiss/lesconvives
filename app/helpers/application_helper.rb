module ApplicationHelper
  def show_navbar_condition
    params[:action] != "home" && params[:controller] != "pages"
    params[:action] != "new" && params[:controller] != "devise/sessions"
  end
end
