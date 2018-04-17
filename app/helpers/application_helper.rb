module ApplicationHelper
  # ページごとの完全なタイトルを返します。
  def full_title(page_title = '')
    base_title = 'Forever Idea Stock Note'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  # タイトルが長い場合、短縮系にする
  def display_title(title)
    if title.length > 12
      title[0, 12] + '...'
    else
      title
    end
  end
end
