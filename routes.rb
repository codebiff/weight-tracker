class Application < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get "/" do
    @weights = WeightStore.all      
    erb :index
  end

  post "/new" do
    weight = WeightStore.create({:kg => params[:kg]})
    if weight.save
      flash[:good] = "0.3"
      redirect "/"
    else
      flash[:error] = "Didn't save for some reason"
      redirect "/"
    end
  end

  get "/delete/:id" do
    if WeightStore.get(params[:id]).destroy
      flash[:deleted] = params[:id]
    else
      flash[:error] = "Didn't delete for some reason"
    end
    redirect "/"
  end

  # get "/css/main.css" do
  #   sass :main, {:load_paths => ["public/css"]}
  # end

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