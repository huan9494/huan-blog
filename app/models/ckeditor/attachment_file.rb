class Ckeditor::AttachmentFile < Ckeditor::Asset
  mount_uploader :data, CkeditorAttachmentFileUploader, mount_on: :data_file_name
  self.inheritance_column = nil
  def url_thumb
    @url_thumb ||= Ckeditor::Utils.filethumb(filename)
  end
end
