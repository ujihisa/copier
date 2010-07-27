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
end
