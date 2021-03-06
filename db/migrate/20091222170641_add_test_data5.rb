class AddTestData5 < ActiveRecord::Migration
  def self.up
  	Product.delete_all
	Product.create(:title => 'Pragmatic Version control',
			:description =>
				%{<p>
					This book is a recipe-based approach to using Subversion that will
					get you up and runnign quickly---and correctly. All projects need
					version control: it's a foundational piece of any project's
					infrastructure. yet half of all project teams in the U.S. don't use
					any version control at all. many others don't use it well, and end
					up experiencing time-consuming problems.
				</p>},
			:image_url => '/images/svn/jpg',
			:price => 28.50)
  end

  def self.down
  		Product.delete_all
  end
end
