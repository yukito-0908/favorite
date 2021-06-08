class Post < ApplicationRecord
  belongs_to :user
  has_many :post_items
  acts_as_taggable   # acts_as_taggable_on :tags の省略
  acts_as_taggable_on :skills, :interests  # @post.skill_list とかが使えるようになる
  has_many :likes,  dependent: :destroy
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :post_items
  acts_as_taggable   # acts_as_taggable_on :tags の省略
# 参)複数設定も可能↓
  acts_as_taggable_on :skills, :interests  # @post.skill
  default_scope->{order(created_at: :desc)}
  has_many :notifications,dependent: :destroy


 def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def liked_by?(user)
    likes.where(user_id: user_id).exists?
  end
  
  
   def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end




  mount_uploaders :images, ImageUploader
  enum genre_name: { 寿司・魚料理: 0, 和食・日本料理: 1, ラーメン・麺類: 2, 丼もの・揚げ物: 3,
                    お好み焼き・粉物: 4, 郷土料理: 5, アジア・エスニック: 6, 中華: 7,
                    イタリアン: 8, 要職・西洋料理: 9,  フレンチ: 10,  アメリカ料理: 11,
                    アフリカ料理: 12,  珍しい各国料理: 13,  焼肉・ステーキ: 14,  焼き鳥・串料理: 15,
                    こだわり肉料理: 16,  鍋: 17,  しゃぶしゃぶ・すき焼き: 18,  居酒屋・バー: 19,
                    カフェ・スイーツ: 20,  ファミレス・ファストフード: 21, ピッフェ・バイキング: 22}
end
