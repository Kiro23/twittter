module ApplicationHelper
    
    def full_title (title)
        if :title.empty? 
            "Twitter" 
            else 
                "Twitter | " + title 
        end
    end
end
