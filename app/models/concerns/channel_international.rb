module ChannelInternational
  extend ActiveSupport::Concern

  included do
    def method_missing(name, *args)
      if name =~ /(.*)_text$/
        attr = $1
        I18n.t(i18n_text_key(attr), attr)
      else
        super
      end
    end

    def i18n_text_key(key)
      puts "#{self.class.model_name.i18n_key}.#{self.key}.#{key}"
      "#{self.class.model_name.i18n_key}.#{self.key}.#{key}"
    end
  end
end
