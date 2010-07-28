module Copier
  class NotSupported < StandardError; end
end
def Copier(text, raise_error=true)
  case RUBY_PLATFORM
  when /darwin/
    IO.popen('pbcopy', 'w') {|io| io.write text }
  else
    raise Copier::NotSupported, RUBY_PLATFORM + " is not supported yet by Copier." if raise_error
  end
end
