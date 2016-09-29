# email account password is required
# you can pass it through ENV or store in .env file
# for example MAIL_PASSWORD=12345
require 'dotenv'
Dotenv.load

IMAP_SERVER = 'podbor.tarifer.ru'
MAIL_LOGIN = 'podbor'
MAIL_PASSWORD = ENV['MAIL_PASSWORD']
WORKING_MAILBOX = 'INBOX.processed'
AVAILABLE_ATTACHMENT_TYPES = %w(html pdf csv xls xlsx txt)
UID_PATH = 'last_uid'
ATTACHMENTS_PATH = ENV['ATTACHMENTS_PATH'] || 'attachments'
