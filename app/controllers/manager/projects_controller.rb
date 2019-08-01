class Manager::ProjectsController < ProjectsController
    def create     
        super        
       if @project.save
       redirect_to manager_projects_path, notice: 'Project was successfully created.'
        else
          render :new 
        end
   end
   
   def update 
     super 
     respond_to do |format|
       if @project.update(project_params)
         format.html { redirect_to manager_projects_path, notice: 'Project was successfully updated.' }
       else
         format.html { render :edit }
       end
     end
   end

   def destroy
     super
     respond_to do |format|
       format.html { redirect_to manager_projects_path, notice: 'Project was successfully destroyed.' }
     end
   end
   def show
     super
   end
end
