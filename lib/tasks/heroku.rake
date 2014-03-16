 namespace :herokudb do

  # Makes a backup of the production database
  task :backup_production do
    system 'heroku pgbackups:capture --expire -r production'
  end

  # Makes a backup of the staging database
  task :backup_staging do
    system 'heroku pgbackups:capture --expire -r staging'
  end

  # Restores the staging site from the latest production backup
  task :update_staging => [:backup_staging, :backup_production] do
    system 'heroku pgbackups:restore DATABASE -r staging $(heroku pgbackups:url -r production)'
  end

  # Dumps the production database to a local file
  task :save_production => :backup_production do
    system "curl -o #{Rails.root.join('tmp', 'production.dump')} $(heroku pgbackups:url -r production)"
  end

  # Restores the local development database from the production dump
  task :import => :save_production do
    local_config = Rails.configuration.database_configuration.fetch("development")
    local_db     = local_config.fetch("database")
    local_user   = local_config.fetch("username")
    host         = local_config.fetch("host", 'localhost')
    system "pg_restore --verbose --clean --no-acl --no-owner -h #{host} -U #{local_user} -d #{local_db} #{Rails.root.join('tmp', 'production.dump')}"
  end
end
