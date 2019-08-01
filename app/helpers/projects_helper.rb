module ProjectsHelper
    def options_for_managers
        @managers = Manager.all
    end

    def get_manager_name(id)
        @manager = Manager.find(id)
        @manager.name
    end

end
