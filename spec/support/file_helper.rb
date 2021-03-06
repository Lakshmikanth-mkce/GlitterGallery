module FileHelper

  def file_upload(project, file_name)
    file = [ActionDispatch::Http::UploadedFile.new(
      tempfile: upload(file_name),
      filename: file_name
    )]
    post :file_upload, user_id: project.user.username,
                       id: project.name,
                       file: file
  end

  # updates old_file with new_file
  def file_update(project, old_file, new_fie)
    file = ActionDispatch::Http::UploadedFile.new(
      tempfile: upload(new_fie),
      filename: new_fie,
      original_filename: old_file
    )
    post :file_update, user_id: project.user.username,
                       id: project.name,
                       branch: 'master',
                       destination: new_fie,
                       message: 'update image',
                       file: file
  end

  def add_image(project, image)
    file = [ActionDispatch::Http::UploadedFile.new(
      tempfile: upload(image),
      filename: image
    )]
    project.add_images(
      'master',
      nil,
      file,
      project.user.git_author_params
    )
  end

  def update_image(project, old_image, new_image)
    file = ActionDispatch::Http::UploadedFile.new(
      tempfile: upload(new_image),
      filename: new_image,
      original_filename: old_image
    )
    project.update_image(
      'master',
      old_image,
      file,
      project.user.git_author_params,
      "updated image #{old_image}"
    )
  end

  # generateds readme file and returns its path
  def generate_readme
    readme_path = File.join(Glitter::Application.config.repo_path, 'readme.md')
    File.write(
      readme_path,
      <<-RUBY.strip_heredoc)
        ## HEAD

        * bullet1
        * bullet2
      RUBY
    readme_path
  end

  # adds a readme to the project
  def add_readme(project)
    file_path = generate_readme
    file = [ActionDispatch::Http::UploadedFile.new(
      tempfile: File.new(file_path),
      filename: 'readme.md'
    )]
    project.add_images(
      'master',
      nil,
      file,
      project.user.git_author_params
    )
  end

  private

  # helper to find the file to upload
  def upload(file_name)
    File.new("#{Rails.root}/spec/factories/files/#{file_name}")
  end
end
