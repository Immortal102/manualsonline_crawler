namespace :db do
  task :populate_brands_with_categories => :environment do
    time1 = Time.now

    puts 'Starting Brands populating'

    bs = BrandsService.new
    bs.populate_db!

    time2 = Time.now
    puts "Completed in #{(time2 - time1)/60} minutes"
    puts "errors: #{bs.errors.inspect}" if bs.errors.any?


    puts 'Starting Categories populating'
    errors = []
    Brand.all.each do |brand|
      cs = CategoriesService.new(brand)
      cs.populate_db!
      errors << cs.errors
    end

    time3 = Time.now
    puts "Completed in #{(time3 - time1)/60} minutes"
    puts "errors: #{errors.inspect}" if errors.any?
  end
end
