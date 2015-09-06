namespace :posts do
  task resave: :environment do
    count = Post.find_each(&:save).length
    puts "Re-saved #{count} post(s)"
  end
  task set_word_count: :environment do
    Post.find_each do |post|
      post.update_attribute(:word_count, post.count_words)
    end
  end
end
