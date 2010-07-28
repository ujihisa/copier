unless respond_to? :require_relative
  def require_relative(o)
    require File.dirname(__FILE__) + "/#{o}"
  end
end

require_relative '../lib/copier'

describe 'Copier()' do
  it 'copies text on Mac OS X' do
    a = rand.to_s
    Copier(a)
    `pbpaste`.chomp.should == a
  end
  
  it 'raises error in not supported env' do
    RUBY_PLATFORM = "hi"
    lambda { Copier("a") }.should raise(Copier::NotSupported)
  end

  it 'but not raise raise_error=false' do
    RUBY_PLATFORM = "hi"
    lambda { Copier("a",false) }.should_not raise(Copier::NotSupported)
  end
end
