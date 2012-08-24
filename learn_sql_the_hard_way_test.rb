require 'test/unit'
require 'sqlite3'

class LearnSqlTheHardWayTest < Test::Unit::TestCase
  def setup
    @db = SQLite3::Database.new 'test.db'
  end

  def teardown
    File.delete 'test.db'
  end

  def test_creating_tables
    @db.execute <<-SQL
      -- Create a 'person' table with following fields below, 'id' is a primary key
    SQL

    table_info = [[0, 'id', 'INTEGER', 0, nil, 1],
                 [1, 'first_name', 'TEXT', 0, nil, 0],
                 [2, 'last_name', 'TEXT', 0, nil, 0],
                 [3, 'age', 'INTEGER', 0, nil, 0]]

    assert_equal table_info, @db.execute('PRAGMA table_info(person)')
  end
end
