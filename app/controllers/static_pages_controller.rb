require 'mongoid/grid_fs'

class StaticPagesController < ApplicationController
  skip_before_filter :check_user, only: :landing

  def home
    # @services = current_user.services
    # @name = current_user.name
    # @last_sign_in = current_user.last_sign_in_at
  end

  def landing
    @users = User.all
  	respond_to do |format|
  	  format.html { render "static_pages/landing" }
  	end
  end

  def help
    pdf_filename = File.join(Rails.root, "12.pdf")
    send_file(pdf_filename, :filename => "12.pdf", :type => "application/pdf")
  end

  def reports
    grid_fs = Mongoid::GridFs
    # f = grid_fs.put(readable)

    # grid_fs.get(f.id)
    # grid_fs.delete(f.id)

    # g = grid_fs.get(f.id)
    # g.data # big huge blob
    # g.each { |chunk| file.write(chunk) } # streaming write
    @files = []
    files_ids = current_user.reports_ids
    logger.info files_ids
    files_ids.each do |file_id|
      file_obj = grid_fs.get(file_id)
      @files << {id: file_id}
      File.open(Rails.root.join('app', 'assets', "#{file_id}.docx"), 'wb') do |f|
        f.write(file_obj.data)
      end

    end
    logger.info files_ids
  end

  def download_docx
    send_file(
        Rails.root.join('app', 'assets', "#{request.path_parameters[:id]}.docx"),
        filename: 'demo1.docx',
        type: 'application/docx',
        # disposition: 'inline'
    )
    # redirect_to reports_url
  end

end
