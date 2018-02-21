namespace :db do
  task :populate_local_brands_with_categories => :environment do
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

  task :populate_all_remote_brands => :environment do
    time1 = Time.now

    puts 'Starting Brands populating from "http://manualsonline.com/brands/"'

    bs = BrandsService.new(true)
    bs.populate_db!

    time2 = Time.now
    puts "Completed in #{(time2 - time1)/60} minutes"
    puts "errors: #{bs.errors.inspect}" if bs.errors.any?
  end

  task :populate_all_brand_categories => :environment do
    time1 = Time.now

    puts 'Starting All Brand\'s Categories populating'
    errors = []
    b_size = Brand.count

    Brand.all.each do |brand|
      puts '>'*80
      puts "Process brand: '#{brand.name}' categories"
      puts "#{b_size -= 1} brands left"
      cs = CategoriesService.new(brand, false)
      cs.populate_db!
      errors << cs.errors
      puts "Complete processing brand: '#{brand.name}' categories"
      puts "errors: #{cs.errors.inspect}" if cs.errors.any?
      puts '<'*80
    end

    time2 = Time.now
    puts "Completed in #{(time2 - time1)/60} minutes"
    puts "errors: #{errors.inspect}" if errors.any?
  end

  task :populate_all_brand_category_products, [:limit, :offset] => :environment do |t, args|

    time1 = Time.now

    puts 'Starting products populating'
    errors = []
    brands = (args.limit && args.offset) ? Brand.ordered.limit(args.limit).offset(args.offset) : Brand.ordered
    b_size = brands.count

    brands.each do |brand|
      puts '>'*80
      puts "Process brand: '#{brand.name}'"
      puts "#{b_size -= 1} brands left"

      categories = brand.categories
      c_size = categories.count

      categories.each do |category|
        puts '-'*80
        puts "     Process category: '#{category.name}'"
        puts "     #{c_size -= 1} categories left"

        bcs = ProductsService.new(brand, category)
        bcs.populate_db!
        errors << bcs.errors

        puts "     Complete processing category: '#{category.name}'"
        puts '-'*80
      end

      puts "Complete processing brand: '#{brand.name}' categories"
      puts "errors: #{errors.inspect}" if errors.any?
      puts '<'*80
    end

    time2 = Time.now
    puts "Completed in #{(time2 - time1)/60} minutes"
    puts "errors: #{errors.inspect}" if errors.any?
  end
end
