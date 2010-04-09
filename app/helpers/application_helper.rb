# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Block method that creates an area of the view that
  # is only rendered if the request is coming from an
  # anonymous user.
  def anonymous_only(&block)
    if !logged_in?
      block.call
    end
  end

  # Block method that creates an area of the view that
  # only renders if the request is coming from an
  # authenticated user.
  def authenticated_only(&block)
    if logged_in?
      block.call
    end
  end


  def table_actions(edit_url, delete_url, item)
    #edit_url = edit_category_path(item)
    #delete_url = category_path(item)

    parts = []
    parts << link_to(image_tag("edit.png"), edit_url, :title => t(:edit))
    parts << "&nbsp;"

    parts << link_to(image_tag("delete.png"), delete_url, :method => "delete",
                     :title => t(:delete),
                     :confirm => t(".confirm_for_delete", :name => item.to_s))

    parts.join("\n").html_safe
  end



end

