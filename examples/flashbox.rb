require File.dirname(__FILE__) + '/../lib/flashbox'

require 'ruby-debug'

describe 'module Flashbox' do

  attr_accessor :flash
  
  describe 'module ControllerMethods' do
    include Flashbox::ControllerMethods

    describe '#add_feedback' do
      it 'should set flash[:feedback]' do
        flash.should_receive(:[]=).with :feedback, %w{ foo bar }
        add_feedback('foo', 'bar')
      end
    end

    describe '#add_info' do
      it "should call add_feedback with message and 'info'" do
        self.should_receive(:add_feedback).with 'foo', 'info'
        add_info('foo')
      end
    end

    describe '#add_warning' do
      it "should call add_feedback with message and 'warning'" do
        self.should_receive(:add_feedback).with 'foo', 'warning'
        add_warning('foo')
      end
    end

    describe '#add_error' do
      it "should call add_feedback with message and 'error'" do
        self.should_receive(:add_feedback).with 'foo', 'error'
        add_error('foo')
      end
    end
  end


  describe 'module Helpers' do
    include Flashbox::Helpers
    
    def javascript_tag(&block); block.call; end
    
    describe '#flashbox_init' do
      it "should add 'jQuery.noConflict();' to the output" do
        flash.should_receive(:[]).with(:feedback).and_return nil
        flashbox_init.should match(/jQuery.noConflict\(\);/)
      end
      
      it 'should generate flashbox javascript if there is feedback to render' do
        flash.stub!(:[]).with(:feedback).and_return %w{ foo bar }
        flashbox_init.should match(/jQuery\(document\)\.ready\(function\(\$\)/)
      end
      
      it 'should pass the flash contents to facebox' do
        flash.should_receive(:[]).with(:feedback).any_number_of_times.and_return %w{ foo bar }
        flashbox_init.should match(/jQuery\.facebox\(\'foo\'\, \'feedback bar\'\)/)
      end
    end
  end
end