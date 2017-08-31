class Post
	attr_accessor :id, :title, :body

	def self.open_connection
		PG.connect( dbname: "blogsdest9")
	end

	def self.hydrate post_data

    post = Post.new
    # hash with string keys - post_data['id']
    # setter method - e.g get data and set as post.id
    post.id = post_data['id']
    post.title = post_data['title']
    post.body = post_data['body']

    post

	end

	def self.all 
		conn = self.open_connection
		sql = "SELECT * FROM post ORDER BY id"
		result = conn.exec(sql)

		post = result.map do |post|
			self.hydrate post
		end
		post

	end

	def self.find id
		# instance of the connection method
		conn = self.open_connection
		sql = "SELECT * FROM post WHERE id = #{id} "
		result = conn.exec(sql)

		self.hydrate result[0]
	end

	def save 
		conn = Post.open_connection
		sql = "INSERT INTO post (title, body) VALUES ('#{self.title}','#{self.body}')"
		conn.exec(sql)

	end

	def update
		conn = Post.open_connection
		sql = "UPDATE post SET title='#{self.title}', body='#{self.body}' WHERE id = #{self.id}"
		conn.exec(sql)
	end

	def self.destroy id
		conn = self.open_connection
		sql = "DELETE FROM post where id = #{id}"
		conn.exec(sql)
	end




end