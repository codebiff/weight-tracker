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
      (WeightConverter.new(Weighin.first.kg).kg - WeightConverter.new(Weighin.last.kg).kg).round(1)
    end

    def current_weight
      WeightConverter.new(Weighin.last.kg).kg
    end

    def start_weight
      WeightConverter.new(Weighin.first.kg).kg
    end

    def goal
      settings.weight_goal
    end

    def weight_loss_progress
      (current_weight - goal).round(1)
    end

    def weight_loss_progress_percentage
      return 100 if current_weight <= goal
      ((start_weight - current_weight) * (100 / (start_weight - goal))).floor
    end

    def weight_diff(now, prev)
      diff        = WeightConverter.new( now - prev )
      diff_lbs    = ( WeightConverter.new(now).lbs - WeightConverter.new(prev).lbs )
      case 
      when diff.kg < 0
        diff_label = "label-success"
      when diff.kg > 0
        diff_label = "label-important"
      else
        diff_label = ""
      end
      OpenStruct.new(:kg => diff.kg, :lbs => diff_lbs, :bmi => diff.bmi, :label => diff_label)
    end

    def graph(weights)
      x_labels = weights.map{|w| w.created_at.strftime("%d %b")}.join("|")
      y_min    = weights.min_by{|w| w.kg }.kg - 0.5
      y_max    = weights.max_by{|w| w.kg }.kg + 0.5
      data     = weights.map{|w| WeightConverter.new(w.kg).kg}.join(",")
      "http://chart.googleapis.com/chart?cht=lc&chs=960x300&chxt=x,y&chxr=1,#{y_min},#{y_max}&chd=t:0|#{data}&chds=#{y_min},#{y_max}&chls=5&chxl=0:|  #{x_labels}&chg=10,10"
    end

  end

end