 
class RegistrationsController < Devise::RegistrationsController
    def create
      super do
          resource.tag_list = params[:name, :type]
          resource.save
      end
    end
  end
  