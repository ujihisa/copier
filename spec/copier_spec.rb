unless respond_to? :require_relative
  def require_relative(o)
    require File.dirname(__FILE__) + "/#{o}"
  end
end

require_relative '../lib/copier'

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
      Copier.disable_config_file = false
    end

    it '.copy_method can copy by block' do
      Copier.copy_method = lambda do |a|
        a.should == "Copier will be used over ssh"
      end
      Copier("Copier wille be used over ssh")
    end
  end
end
