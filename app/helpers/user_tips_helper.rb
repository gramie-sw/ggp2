module UserTipsHelper

  #tested by spec of _tips_table.slim
  def user_tips_table_tr_attributes(show_as_link, tip_id)
    if show_as_link
      {'class' => 'link-row', 'data-href' => "#{edit_multiple_tips_path(tip_ids: [tip_id])}"}
    else
      {}
    end
  end
end
