# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

module Natural
  class DatabaseUser
    include ConnectionProvidable
    attr_reader :username, :password

    def initialize(username, password = nil)
      @username = username
      @password = password
    end

    def create
      connection.exec(
        """
        CREATE USER \"#{@username}\" WITH PASSWORD \'#{@password}\'
        """
      )
      self
    end

    def destroy
      connection.exec(
        """
        DROP USER \"#{@username}\";
        """
      )
    end

    def exists?
      '1' == connection.exec(
        """
        SELECT 1 FROM pg_roles WHERE rolname='#{@username}'
        """
      ).values[0].try(:[], 0)
    end

    def grant(database)
      connection.exec(
        """
        GRANT ALL PRIVILEGES ON DATABASE \"#{database.identifier}\" TO \"#{@username}\";
        """
      )
    end
  end
end
