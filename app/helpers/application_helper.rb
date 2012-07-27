module ApplicationHelper

  INDENT = '       '

  def indent(text, n = 1)
    text.prepend(INDENT * n)
  end

end
