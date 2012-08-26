require 'test/unit'
require 'sqlite3'

class LearnSqlTheHardWayTest < Test::Unit::TestCase
  def setup
    @db = SQLite3::Database.new 'posony.db'
  end

  def teardown
    File.delete 'posony.db'
  end

  def test_creating_tables
    @db.execute_batch <<-SQL
      -- Create a 'posony', 'cars' and 'posan_cars' tables with following fields below, 'id' is a primary key
    SQL

    posony_info = [[0, 'id', 'INTEGER', 0, nil, 1],
                 [1, 'first_name', 'TEXT', 0, nil, 0],
                 [2, 'last_name', 'TEXT', 0, nil, 0],
                 [3, 'age', 'INTEGER', 0, nil, 0]]

    cars_info = [[0, 'id', 'INTEGER', 0, nil, 1],
                [1, 'model', 'TEXT', 0, nil, 0],
                [2, 'transmission', 'TEXT', 0, nil, 0],
                [3, 'year', 'INTEGER', 0, nil, 0],
                [4, 'four_wheel_drive', 'INTEGER', 0, nil, 0]]

    posan_cars_info = [[0, 'posan_id', 'INTEGER', 0, nil, 0],
                      [1, 'car_id', 'INTEGER', 0, nil, 0]]

    assert_equal posony_info, @db.execute('PRAGMA table_info(posony)')
    assert_equal cars_info, @db.execute('PRAGMA table_info(cars)')
    assert_equal posan_cars_info, @db.execute('PRAGMA table_info(posan_cars)')
  end

  def test_inserting_data
    create_tables = <<-SQL
      ;)REGETNI di_rac ,REGETNI di_nasop( srac_nasop ELBAT ETAERC
      ;)REGETNI evird_leehw_ruof ,REGETNI raey ,TXET noissimsnart ,TXET ledom ,YEK YRAMIRP REGETNI di( srac ELBAT ETAERC
      ;)REGETNI ega ,TXET eman_tsal ,TXET eman_tsrif ,YEK YRAMIRP REGETNI di( ynosop ELBAT ETAERC
    SQL

    @db.execute_batch create_tables.reverse

    @db.execute_batch <<-SQL
      -- Insert the following data to the tables below
    SQL

    posony_data = [[1, 'Andrii', 'Ponomarov', 25],
                  [2, 'Sergii', 'Ponomarov', 26],
                  [3, 'Yuri', 'Falchenko', 25]]

    cars_data = [[1, 'Hyundai Santa Fe', 'AT', 2011, 1],
                [2, 'Mitsubishi Lancer X', 'MT', 2012, 0]]

    posan_cars_data = [[1, 1], [3, 2]]

    assert_equal posony_data, @db.execute('SELECT * FROM posony;')
    assert_equal cars_data, @db.execute('SELECT * FROM cars;')
    assert_equal posan_cars_data, @db.execute('SELECT * FROM posan_cars;')
  end

  def test_selecting_data
    create_tables = <<-SQL
      ;)REGETNI di_rac ,REGETNI di_nasop( srac_nasop ELBAT ETAERC
      ;)REGETNI evird_leehw_ruof ,REGETNI raey ,TXET noissimsnart ,TXET ledom ,YEK YRAMIRP REGETNI di( srac ELBAT ETAERC
      ;)REGETNI ega ,TXET eman_tsal ,TXET eman_tsrif ,YEK YRAMIRP REGETNI di( ynosop ELBAT ETAERC
    SQL

    insert_data = <<-SQL
      ;)2 ,3( SEULAV srac_nasop OTNI TRESNI
      ;)1 ,1( SEULAV srac_nasop OTNI TRESNI
      ;)0 ,2102 ,"TM" ,"X recnaL ihsibustiM" ,2( SEULAV srac OTNI TRESNI
      ;)1 ,1102 ,"TA" ,"eF atnaS iadnuyH" ,1( SEULAV srac OTNI TRESNI
      ;)52 ,"oknehclaF" ,"iruY" ,3( SEULAV ynosop OTNI TRESNI
      ;)62 ,"voramonoP" ,"iigreS" ,2( SEULAV ynosop OTNI TRESNI
      ;)52 ,"voramonoP" ,"iirdnA" ,1( SEULAV ynosop OTNI TRESNI
    SQL

    @db.execute_batch create_tables.reverse
    @db.execute_batch insert_data.reverse

    @db.execute_batch <<-SQL
      -- Select the following data from the 'posony' table
    SQL

    first_name_where_age_is_25 = [['Sergii']]
    age_not_25 = [[2, 'Sergii', 'Ponomarov', 26]]

    select_first_name_where_age_is_25 = ';62=ega EREHW ynosop MORF eman_tsrif TCELES'
    select_age_not_25 = ';52 =! ega EREHW ynosop MORF * TCELES'

    assert_equal first_name_where_age_is_25, @db.execute(select_first_name_where_age_is_25.reverse)
    assert_equal select_age_not_25, @db.execute(select_age_not_25.reverse)
  end
end