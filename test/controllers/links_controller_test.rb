require 'test_helper'

class LinksControllerTest < ActionController::TestCase

  setup do
    @link = links(:duff)
    sign_in :user, users(:homer)
  end

  test 'should redirect when signed out' do
    sign_out :user
    get :index
    assert_response :found
  end

  test 'should get index with links for current_user' do
    get :index
    assert_response :success
    assert_not_nil assigns(:links)
    assert assigns(:links).count, 2
  end

  test 'should get index with new link' do
    get :index
    assert_response :success
    assert_not_nil assigns(:new_link)
  end

  test 'should create link belonging to current_user' do
    assert_difference('Link.count') do
      post :create, link: { 
        url: 'http://g1.globo.com'
      }
    end

    assert_equal assigns(:link).user, users(:homer)
    assert_redirected_to link_path(assigns(:link))
  end

  test 'should update link' do
    patch :update, id: @link, link: {
      url: @link.url 
    }
    assert_redirected_to link_path(assigns(:link))
  end

  test 'should not update link belonging to other user' do
    assert_raise ActiveRecord::RecordNotFound do
      patch :update, id: links(:google), link: {
        url: 'http://should-not-update.com'
      }
    end
  end

  test 'should destroy link' do
    assert_difference('Link.count', -1) do
      delete :destroy, id: @link
    end

    assert_redirected_to links_path
  end

  test 'should not destroy link belonging to other user' do
    assert_raise ActiveRecord::RecordNotFound do
      delete :destroy, id: links(:google)
    end
  end
end
