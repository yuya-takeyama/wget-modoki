require 'optparse'

module Wget
  class Option
    OPTS = [
      [:user_agent, 'user-agent', 'u'],
      [:password, 'passowrd'],
      [:user, 'user'],
    ]

    def initialize(options = {})
      @options = options
    end

    def argv=(argv)
      @argv = argv
      @options = parse_opt(argv)
    end

    def parse_opt(argv)
      options = {}
      opt = OptionParser.new

      OPTS.each do |sym, long, short|
        opt.on("-#{short} VAL") {|v| options[sym] = v } if short
        opt.on("--#{long}=VAL") {|v| options[sym] = v }
      end

      opt.parse!(argv)

      argv.each do |arg|
        options[:url] = arg if arg =~ %r{^https?://}
      end

      options
    end

    OPTS.each do |opt|
      sym, long, short = opt

      class_eval %{
        def #{sym}
          @options[:#{sym}] if has_#{sym}?
        end

        def has_#{sym}?
          @options.has_key?(:#{sym}) if @options[:#{sym}]
        end
      }
    end

    def has_url?
      @options.has_key?(:url) and @options[:url]
    end

    def url
      @options[:url] if @options.has_key?(:url)
    end

    def filename
      @options[:url][%r{[^/]+?$}] || 'index.html'
    end
  end
end
