module Copier
  class NotSupported < StandardError; end

  class Config < Hash
    def method_missing(name,*args)
      if /=$/ =~ name.to_s
        self[name] = args[0]
      else
        self[name]
      end
    end
  end

  class << self
    def load_config(f = '~/.copier')
      fn = File.expand_path(f)
      @default_config = Config.new({:copy => nil})
      config = @default_config
      eval(File.read(fn)) rescue nil
      @config = config
      @config_loaded = true
    end

    def method_missing(name, *args)
      @config.__send__(name, *args)
    end

    def disable_config_file=(a)
      @disable_config_file = a
      if a
        @config = @default_config
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
  Copier.load_config unless Copier.config_loaded && !Copier.disable_config_file

  if Copier.copy_method && !Copier.disable_config
    Copier.copy_method.call(text)
    return
  end

  case RUBY_PLATFORM
  when /darwin/
    IO.popen('pbcopy', 'w') {|io| io.write text }
  when /cygwin/
    File.open('/dev/clipboard', 'wb') {|io| io.write text.gsub("\x0A", "\n") }
  else
    raise Copier::NotSupported, RUBY_PLATFORM + " is not supported yet by Copier."
  end
end
