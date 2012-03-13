class Application < Sinatra::Base

  get "/" do
    @weights = Weighin.last_x_days(7)      
    erb :index
  end

  post "/new" do
    weight = Weighin.create({:kg => params[:kg]})
    if weight.save
      redirect "/"
    else
      redirect "/"
    end
  end

  get "/history/:range" do
    if params[:range] =~ /^[-+]?[0-9]+$/
      @history_title = "Last #{params[:range]} days..."
      @weights = Weighin.last_x_days(params[:range].to_i)
    else
      @history_title = "Entire history..."
      @weights = Weighin.all(:order => [:created_at.desc])
    end
    erb :history
  end
  
  get "/delete/:id" do
    Weighin.get(params[:id]).destroy
    redirect "/"
  end

  get "/edit/:id/:kg" do
    weight = Weighin.get(params[:id].to_i)
    weight.update(:kg => params[:kg])
    redirect "/"
  end

  get "/css/main.css" do
    sass :main, {:load_paths => ["public/css"]}
  end

  get "/js/main.js" do
    coffee :main
  end

  # Pull latest commit from GitHub automatically
  post "/pull" do
    system "git pull && touch tmp/restart.txt"
  end

  not_found do 
    erb :'404'
  end

end