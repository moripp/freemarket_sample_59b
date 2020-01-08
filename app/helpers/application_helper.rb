module ApplicationHelper

  # ビューに改行も表示させるメソッド
  def line_feed_display(value)
    safe_join(value.split("\n"), tag(:br))
  end

  # 3桁区切りで数字を表示させるメソッド
  def digit_separator(value)
    value.to_s(:delimited, delimiter: ',')
  end

end
