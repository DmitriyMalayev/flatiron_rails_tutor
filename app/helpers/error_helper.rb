# app/helpers/error_helper.rb
module ErrorHelper
    def show_errors_for(object)
        render partial: "/shared/errors", locals: {object: object} 
    end  
end 

# We use this helper for rendering a partial in the views/shared/_errors.html.erb 
# We don't include the _ when rendering 
