class PictureProcessor

  @queue = :picture_processor_queue

  #def self.perform(user_id, picture_key)
  #  user = User.find(user_id)
  #  user.key = picture_key
  #  user.remote_picture_url = user.picture.direct_fog_url(:with_path => true)
  #  puts "He pasado por el worker #{user.name}"
  #  puts "Esta es la url remota #{user.remote_picture_url}"
  #  puts "Esta es la url local #{user.picture.current_path}"
  #  image = MiniMagick::Image.open(user.picture.current_path)
  #  image.resize "50x50"
  #  image.write "#{user.picture.current_path}"
  #  puts "Imagen #{user.picture}"
  #  puts "Se ha guardado el proceso en el worker"
  #  user.save!
  #  puts "Se espera que se guarde en el S3"
  #end

  def self.perform(user_id, picture_key, password)
    user = User.find(user_id)
    user.key = picture_key
    user.password = password
    user.password_confirmation = password
    puts "He pasado por el worker #{user.name} con contraseña #{user.password}"
    user.save_and_process_picture(:now => true)
    puts "He salido del worker"
  end


end