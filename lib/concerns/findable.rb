module Concerns
  module Findable

    def find_by_name(name)
      self.all.each do |item|
        if item.name == name
          return item
        end
      end
       return nil
    end

    def find_or_create_by_name(name)
      found_item = find_by_name(name)
      if found_item == nil
        item = self.create(name)
      else
        found_item
      end
    end
  end

end
