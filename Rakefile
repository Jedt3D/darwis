require "fileutils"
require "rake"
require "rspec/core/rake_task"

MIGRATIONS_DIR = "db/migrate"

RSpec::Core::RakeTask.new(:spec)

desc "Run Rubocop"
task :lint do
  sh "bundle exec rubocop"
end

desc "Run tests and lint"
task default: %i[spec lint]

namespace :db do
  desc "Create database"
  task :create do
    require "sequel"
    db_path = ENV.fetch("DATABASE_URL", "sqlite:///db/development.sqlite3").sub("sqlite:///", "")
    FileUtils.mkdir_p(File.dirname(db_path))
    DB = Sequel.connect(ENV.fetch("DATABASE_URL", "sqlite:///db/development.sqlite3"))
    DB.run "CREATE TABLE IF NOT EXISTS schema_info (version INTEGER)"
    puts "✓ Database created: #{db_path}"
  end

  desc "Run database migrations"
  task :migrate do
    require "sequel"
    DB = Sequel.connect(ENV.fetch("DATABASE_URL", "sqlite:///db/development.sqlite3"))
    Sequel.extension :migration
    current_version = DB[:schema_info].first[:version] rescue 0
    target_version = Dir.glob("#{MIGRATIONS_DIR}/*.rb").map do |file|
      File.basename(file).match(/^\d+_(.+)\.rb$/)[1].to_i
    end.max || current_version

    if current_version < target_version
      Sequel::Migrator.run(DB, MIGRATIONS_DIR, target: target_version)
      puts "✓ Migrated to version #{target_version}"
    else
      puts "✓ Already at version #{current_version}"
    end
  end

  desc "Rollback last migration"
  task :rollback do
    require "sequel"
    DB = Sequel.connect(ENV.fetch("DATABASE_URL", "sqlite:///db/development.sqlite3"))
    Sequel.extension :migration
    current_version = DB[:schema_info].first[:version] rescue 0

    if current_version.positive?
      Sequel::Migrator.run(DB, MIGRATIONS_DIR, target: current_version - 1)
      puts "✓ Rolled back to version #{current_version - 1}"
    else
      puts "⚠ No migrations to rollback"
    end
  end

  desc "Drop and recreate database"
  task :reset do
    require "sequel"
    db_path = ENV.fetch("DATABASE_URL", "sqlite:///db/development.sqlite3").sub("sqlite:///", "")
    FileUtils.rm_f(db_path) if File.exist?(db_path)
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    puts "✓ Database reset complete"
  end

  desc "Seed database with sample data"
  task :seed do
    puts "✓ Seeding database..."
  end

  desc "Show current migration version"
  task :version do
    require "sequel"
    DB = Sequel.connect(ENV.fetch("DATABASE_URL", "sqlite:///db/development.sqlite3"))
    version = DB[:schema_info].first[:version] rescue 0
    puts "Current migration version: #{version}"
  end
end

desc "List all available tasks"
task :list do
  system "rake -T"
end
