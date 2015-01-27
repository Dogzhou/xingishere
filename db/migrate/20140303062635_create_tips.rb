# encoding: utf-8
class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips, options: "DEFAULT CHARSET=utf8", comment: '小贴士' do |t|
      t.text :content,  limit: 100, null: false,  comment: "内容"

      t.timestamps
    end
  end
end
