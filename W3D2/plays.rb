require 'sqlite3'
require 'singleton' #makes sure only one instance of db gets created

class PlayDBConnection < SQLite3::Database
  include Singleton
  def initialize
    super('plays.db')
    self.type_translation = true  #all data is same type as data passed in
    self.results_as_hash = true   # results came in as array, easier to receive as a hash
  end
end

class Play
  attr_accessor :title, :year, :playwright_id
  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays") # grabs instance of db
    data.map { |datum| Play.new(datum) }
  end

  def initialize(options) #options hash with defined user colums
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']

  end

  def create
    raise "#{self} already in database" if @id              #is this instance of play already in db
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id) --heredoc
      INSERT INTO
        plays(title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    #SQL injection Attacks (?, ?, ?) protecks against
    #playwright_id == "3; DROP TABLE plays"
    @id = PlayDBConnection.instance.last_insert_row_id  #gets id of last row inserted

  end

  def update
    raise "#{self} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id, @id)
     UPDATE
      plays
     SET
      title = ?, year = ?, playwright = ?
     WHERE
      id = ?
    SQL
  end

  def self.find_by_title(title)
     play = PlayDBConnection.instance.execute(<<-SQL, title)
     SELECT
      *
      FROM
      plays
     WHERE
      title = ?
    SQL
    return nil unless play.length > 0
    Play.new(play.first) #play is stored in an arry
  end

  def self.find_by_playwright(name)
    playwright = Playwright.find_by_name(name)
    raise "#{name} not found in DB" unless playwright

    plays = PLAYDBConnection.instance.execute(<<-SQL, playwright.id)
      SELECT
        *
      FROM
        plays
      WHERE
        playwright_id = ?
      SQL

      plays.map { | play| Play.new(play) }
  end
end





class Playwright

  attr_accessor :name, :birth_year

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM playwright") # grabs instance of db
    data.map { |datum| Playwright.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @birth_year = options['birth_year']
  end

  def create
    raise "#{self} already in database" if @id     #is this instance of play already in db
    PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year) --heredoc
      INSERT INTO
        Playwrights(name, birth_year)
      VALUES
        (?, ?)
    SQL
    #SQL injection Attacks (?, ?, ?) protecks against
    #playwright_id == "3; DROP TABLE plays"
    @id = PlayDBConnection.instance.last_insert_row_id  #gets id of last row inserted

  end

  def update
    raise "#{self} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year, @id)
     UPDATE
      playwrights
     SET
      name = ?, birth_year = ?
     WHERE
      id = ?
    SQL
  end

  def get_plays
    raise "#{self} not in database" unless @id
   plays = PlayDBConnection.instance.execute(<<-SQL, @id)
    SELECT
      *
    FROM
    playwrights
    WHERE
    playwright_id = ?
  SQL

  plays.map {|play| Play.new(play) }
 end
end
