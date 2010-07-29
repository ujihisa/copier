unless respond_to? :require_relative
  def require_relative(o)
    require File.dirname(__FILE__) + "/#{o}"
  end
end

require_relative '../lib/copier'
require 'tempfile'
Copier.config_prepare

describe 'Copier()' do
  describe 'in default case' do
    before do
      Copier.disable_config_file = true
    end

    it 'copies text on Mac OS X' do
      pending 'This platform is not Mac OS X, so you cannot run this case now' unless
        /darwin/ =~ RUBY_PLATFORM
      a = rand.to_s
      Copier(a)
      `pbpaste`.chomp.should == a
    end

    it 'copies text on Windows (cygwin)' do
      pending 'This platform is not Windows (cygwin), so you cannot run this case now' unless
        /cygwin/ =~ RUBY_PLATFORM
      a = rand.to_s
      Copier(a)
      #`pbpaste`.chomp.should == a
      pending 'Please fill this case... I dont know how to paste text'
    end
  end

  describe 'with config' do
    before do
      Copier.disable_config_file = true
      Copier.config_prepare
    end

    it '.copy_method can copy by block' do
      Copier.copy_method = lambda do |a|
        a.should == "Copier will be used over ssh"
      end
      Copier("Copier will be used over ssh")
    end

    it '.copy_file can copy to file' do
      Copier.copy_file = Tempfile.new('copier_spec').path
      Copier("fork it")
      File.read(Copier.copy_file).should == "fork it"
    end
  end
end
