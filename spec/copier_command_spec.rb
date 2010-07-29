describe 'copier command' do
  def paste
    case RUBY_PLATFORM
    when /darwin/
      `pbpaste`
    else
      pending
    end
  end

  before do
    @cmd = File.dirname(__FILE__) + '/../bin/copier'
  end

  it 'copies the first argument' do
    text = rand.to_s
    system @cmd, text
    paste.should == text
  end

  it 'copies stdin' do
    text = rand.to_s
    IO.popen(@cmd, 'w') {|io| io.write text }
    paste.should == text
  end
end
