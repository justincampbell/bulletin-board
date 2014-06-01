require './spec/spec_helper'

describe "/" do
  before { get "/" }

  it "works" do
    assert_equal 200, last_response.status
  end
end
