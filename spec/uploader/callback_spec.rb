# encoding: utf-8

require 'spec_helper'

describe CarrierWave::Uploader do

  it "should keep callbacks on different classes isolated" do
    @uploader_class_1 = Class.new(CarrierWave::Uploader::Base)

    # First Uploader only has default before-callback
    @uploader_class_1._before_callbacks[:cache].should == [:check_whitelist!, :check_blacklist!, :check_content_type_whitelist!, :check_content_type_blacklist!]

    @uploader_class_2 = Class.new(CarrierWave::Uploader::Base)
    @uploader_class_2.before :cache, :before_cache_callback

    # Second Uploader defined with another callback
    @uploader_class_2._before_callbacks[:cache].should == [:check_whitelist!, :check_blacklist!, :check_content_type_whitelist!, :check_content_type_blacklist!, :before_cache_callback]

    # Make sure the first Uploader doesn't inherit the same callback
    @uploader_class_1._before_callbacks[:cache].should == [:check_whitelist!, :check_blacklist!, :check_content_type_whitelist!, :check_content_type_blacklist!]
  end


end
