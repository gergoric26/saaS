module ApplicationHelper
  def markdown(markdown)
    
    extensions = {fenced_code_blocks: true,
                  hard_wrap: true}
    renderer = Redcarpet::Render::HTML.new(extensions)
    redcarpet = Redcarpet::Markdown.new(renderer)
    (redcarpet.render markdown).html_safe
  end
end
