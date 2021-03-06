module ApplicationHelper

# http://hivelogic.com/articles/random-image-rotation-in-rails
  def random_image
    image_files = %w( .jpg .gif .png )
    files = Dir.entries(
      Rails.root.to_s + "/app/assets/images/headers/" 
    ).delete_if { |x| !image_files.index(x[-4,4]) }
    files[rand(files.length)]
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

def markdown(text)
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :tables => true, :strikethrough => true, :fenced_code_blocks => true, :no_intra_emphasis => true)
  return markdown.render(text).html_safe
end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end


end
