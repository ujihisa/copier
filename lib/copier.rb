def Copier(text)
  case RUBY_PLATFORM
  when /darwin/
    IO.popen('pbcopy', 'w') {|io| io.write text }
  else
    raise RUBY_PLATFORM + " is not supported yet by Copier."
  end
end
