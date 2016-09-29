require './settings'
require 'net/imap'
require 'mail'
require 'byebug'

class MailClient
  attr_reader :last_uid

  def initialize
    connect
  end

  def mails_greater_than(uid)
    starting_uid = uid.to_i + 1
    ids = @connection.search("UID #{starting_uid}:*")
    emails = @connection.fetch(ids, ['UID', 'BODY[]'])
    @last_uid = emails.last.attr['UID']
    emails.map { |e| Mail.new e.attr['BODY[]'] }
  end

  private

  def connect
    @connection = Net::IMAP.new(IMAP_SERVER, 993, true, nil, false)
    @connection.login(MAIL_LOGIN, MAIL_PASSWORD)
    @connection.select(WORKING_MAILBOX)
  end
end
