class HashSet
    attr_reader :store
    
    def initialize
        @store = {}
    end
    
    def insert(el)
        store[el] = true
    end
    
    def include?(el)
        store.has_key?(el)
    end
    
    def delete(el)
        return false unless self.include?(el)
        store.delete(el)
        true
    end
    
    def to_a
        store.keys
    end
    
    def union(set2)
        union = HashSet.new
        self.to_a.each  { |el| union.insert(el) }
        set2.to_a.each  { |el| union.insert(el) }
        union
    end
    
    def intersect(set2)
        intersect = HashSet.new
        self.to_a.each do |el|
            next unless set2.include?(el)
            intersect.insert(el)
            end
        end
        intersect
    end
    
    def minus(set2)
        result = HashSet.new
        self.to_a.each do |el|
            next if set2.include?(el)
            result.insert(el)
            end
        end
        result
    end
end
