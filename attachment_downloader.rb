require './mail_client'

class AttachmentDownloader
  def initialize
    @client = MailClient.new
    @uid = File.read(UID_PATH) if File.file?(UID_PATH)
    @uid = @uid.to_i
  end

  def download
    @client.mails_greater_than(@uid).each do |mail|
      download_attachment(mail) if fit_requirements?(mail)
    end
    update_uid
  end

  private

  def download_attachment(mail)
    mail.attachments.each do |a|
      next unless avaible_attachment_type?(a.filename)
      file = File.open(ATTACHMENTS_PATH + '/' + a.filename, 'wb')
      file.write(a.decoded)
      file.close
    end
  end

  def avaible_attachment_type?(filename)
    AVAILABLE_ATTACHMENT_TYPES.each do |ext|
      return true if filename =~ /\.#{ext}$/
    end
    false
  end

  def fit_requirements?(mail)
    regexp = /[0-9]+_(detail|bill|additional_detail)@#{IMAP_SERVER}+/
    !(mail.to.first =~ regexp).nil?
  end

  def update_uid
    return unless @client.last_uid
    file = File.open(UID_PATH, 'wb')
    file.write(@client.last_uid)
    file.close
  end
end
