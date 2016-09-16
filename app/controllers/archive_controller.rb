class ArchiveController < ApplicationController
  def index
    sql = <<__SQL__
INSERT INTO items2 (id, name, price, archive) 
SELECT id, name, price, archive FROM items WHERE archive = true
ON CONFLICT (id) DO UPDATE
  SET name = excluded.name,
  price = excluded.price,
  archive = excluded.archive
__SQL__
  result = ActiveRecord::Base.connection.exec_query(sql)
  render result.to_hash
  end
end
