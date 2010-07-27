def Copier(text)
  case RUBY_PLATFORM
  when /darwin/
    IO.popen('pbcopy', 'w') {|io| io.write text }
  when /cygwin/
    File.open('/dev/clipboard', 'wb') {|io| io.write text.gsub("\x0A", "\n") }
  else
    raise RUBY_PLATFORM + " is not supported yet by Copier."
  end
end
