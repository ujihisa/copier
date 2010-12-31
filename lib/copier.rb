module Copier
  class NotSupported < StandardError; end

  class Config < Hash
    def method_missing(name,*args)
      if /=$/ =~ name.to_s
        self[name.to_s.gsub(/=$/,"").to_sym] = args[0]
      else
        self[name]
      end
    end
  end

  class << self
    def config_prepare
      @config = Config.new()
    end

    def load_config(f = '~/.copier')
      fn = File.expand_path(f)
      self.config_prepare
      config = @config
      eval(File.read(fn)) rescue nil
      @config = config.dup
      @config_loaded = true
    end

    def method_missing(name, *args)
      @config.__send__(name, *args)
    end

    def disable_config_file=(a)
      @disable_config_file = a
      if a
        self.config_prepare
        @config_loaded = false
      end
    end

    def disable_config_file
      @disable_config_file
    end

    def config_loaded
      @config_loaded
    end
  end
end

def Copier(text)
  Copier.load_config unless Copier.config_loaded || Copier.disable_config_file

  if Copier.copy_method
    Copier.copy_method.call(text)
    return
  end

  if Copier.copy_file
    File.open(Copier.copy_file, 'w') {|io| io.write text }
  end

  case RUBY_PLATFORM
  when /darwin/
    IO.popen('pbcopy', 'w') {|io| io.write text }
  when /cygwin/
    File.open('/dev/clipboard', 'wb') {|io| io.write text.gsub("\x0A", "\n") }
  when /linux/
    IO.popen('xclip -selection clipboard', 'w') {|io| io.write text}
  else
    raise Copier::NotSupported, RUBY_PLATFORM + " is not supported yet by Copier."
  end
end
