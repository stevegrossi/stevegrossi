namespace :posts do
  task :resave => :environment do
    Post.find_each(&:save)
  end
  task :set_word_count => :environment do
    Post.find_each do |post|
      post.update_attribute(:word_count, post.count_words)
    end
  end
end
