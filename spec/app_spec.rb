require './spec/spec_helper'

describe BulletinBoard do
  before do
    $redis = MockRedis.new
  end

  it "responds with an empty bulletin by default" do
    get "/"

    assert_equal "", last_response.body
    assert_equal 200, last_response.status
  end

  it "allows the bulletin to be updated" do
    authorize "user", "pass"
    put "/", bulletin: "Beware of Zombies"

    assert_equal 201, last_response.status

    get "/"

    assert_equal "Beware of Zombies", last_response.body
    assert_equal 200, last_response.status
  end

  it "responds unauthorized with the correct user and pass" do
    authorize "foo", "bar"

    put "/"

    assert_equal 401, last_response.status
  end
end
