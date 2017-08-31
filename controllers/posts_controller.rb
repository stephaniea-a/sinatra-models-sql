class PostsController < Sinatra::Base

  # sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')
  
  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") } 

  configure :development do
      register Sinatra::Reloader
  end

  # Why do we use the $ sign - global variable
  $posts = [{
      id: 0,
      title: "Post 1",
      body: "This is the first post"
  },
  {
      id: 1,
      title: "Post 2",
      body: "This is the second post"
  },
  {
      id: 2,
      title: "Post 3",
      body: "This is the third post"
  }];

  get '/' do

      @title = "Blog posts"

      @posts = Post.all
  
      erb :'posts/index'
  
  end

  get '/new'  do
    
    "NEW"
    erb :'posts/new'
    
  end
    
  get '/:id' do
    
    # get the ID and turn it in to an integer
    id = params[:id].to_i

    # make a single post object available in the template
    # @post = $posts[id]
    @post = Post.find id
    erb :'posts/show'
    
  end
    
  post '/' do

    post = Post.new

    post.title = params[:title]
    post.body = params[:body]

    post.save
     
    redirect :"/"

    "CREATE"

    
  end
    
  put '/:id'  do
    
    "UPDATE: #{params[:id]}"

    # data is gathered in the params object
    id = params[:id].to_i
      
    # load the object with the id
    post = Post.find id

    # update the values
    post.title = params[:title]
    post.body = params[:body]

    # save the post
    post.update
      
    # redirect the user to a GET route. We'll go back to the INDEX.
    redirect "/";

    
  end
    
  delete '/:id'  do
    "DELETE: #{params[:id]}"

    id = params[:id].to_i

    Post.destroy id

    redirect :"/"

    
    
    
  end
    
  get '/:id/edit'  do

    id = params[:id].to_i

    @post = Post.find id
    "EDIT: #{params[:id]}"

    erb :"posts/edit"
    
    
    
  end

end