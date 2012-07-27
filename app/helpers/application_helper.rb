module ApplicationHelper

  INDENT = '       '

  def indent(text, n = 1)
    text.prepend(INDENT * n)
  end

  def wrap(text, width = 70, n = 1)
    lines = text.scan(/.{1,#{width}}/)
    lines.map! do |line|
      line.prepend(INDENT * n)
    end
    wrapped_text = lines.join("\n")
    return lines.present? ? wrapped_text : indent(text)
  end

end
