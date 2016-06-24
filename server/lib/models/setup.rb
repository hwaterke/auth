require 'digest'

DB = Sequel.sqlite

DB.create_table? :users do
  primary_key :id
  String :email, null: false, unique: true
  String :password_digest
  DateTime :last_login
  Integer :password_failure_number, null: false, default: 0
  DateTime :password_failure_time
  DateTime :created_at, null: false
end

class User < Sequel::Model
  plugin :secure_password

  def before_create
    self.created_at ||= Time.now
    super
  end
end
