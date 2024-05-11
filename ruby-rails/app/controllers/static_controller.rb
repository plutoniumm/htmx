class StaticController <ActionController::Base
   def root
   end

   def details
      @data = [
         ['Ruby', 'https://www.ruby-lang.org/en/', 'https://www.ruby-lang.org/images/header-ruby-logo@2x.png'],
         ['HTMX', 'https://htmx.org/docs', 'https://htmx.org/img/htmx_logo.2.png'],
         ['Rails', 'https://rubyonrails.org', 'https://rubyonrails.org/assets/images/logo.svg'],
      ]
   end
end