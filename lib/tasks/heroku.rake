# PostgreSQL-only replacement for `heroku db:pull`,
# which the Heroku toolbelt seems ot have broken:
# http://stackoverflow.com/q/13001166/
#
# It throws some errors aroundrearding `plpgsql`,
# but everything still seems to work.

namespace :herokudb do
  task :capture do
    system 'heroku pgbackups:capture --expire -a stevegrossi'
  end
  task :save => :capture do
    system 'curl -o tmp/latest.dump `heroku pgbackups:url -a stevegrossi`'
  end
  task :import => :save do
    system 'pg_restore --verbose --clean --no-acl --no-owner -h localhost -U rails -d stevegrossi_development tmp/latest.dump'
  end
end
