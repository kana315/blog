class NoticeMailer < ApplicationMailer
  def notice_email(blog)
    @blog = blog
    @user = @blog.user

    mail to: 'admin@dic.com', subject: "投稿確認のメール"
  end
end
