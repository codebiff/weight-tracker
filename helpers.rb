class Application < Sinatra::Base

  before do  
    @title = "Home"
  end

  helpers do 
    include Rack::Utils
    alias_method :h, :escape_html

    def tidy_date(date)
      date.strftime("#{date.day.ordinalize} of %B, %Y")
    end

    # Pluralize any word (2, post) (5, dice, die)
    def pluralize(n, singular, plural=nil)
      if n == 1 
        "1 #{singular}"
      elsif plural
        "#{n} #{plural}"
      else
        "#{n} #{singular}s"
      end
    end

    # Loads partial view into template. Required vriables into locals
    def partial(template, locals = {})
      erb(template, :layout => false, :locals => locals)
    end

    def weight_loss
      (WeightStore.first.kg - WeightStore.last.kg).round(1)
    end

    def current_weight
      WeightStore.last.kg
    end

    def start_weight
      WeightStore.first.kg
    end

    def goal
      79
    end

    def weight_loss_progress
      (start_weight - current_weight) * (100 / (start_weight - goal))
    end

    def weight_diff_from_last_time
      0.3
    end

  end

end