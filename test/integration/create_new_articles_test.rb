require 'test_helper'

class CreateNewArticlesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "Doe", email: "doe@example.com", password: "password", admin: false)
  end
  test "creating new articles" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post_via_redirect articles_path, article: {title: "Testing Creating",
        description: "Making an integration test", user_id: @user.id}
    end
    assert_template 'articles/show'
    assert_match "integration test", response.body
  end
end