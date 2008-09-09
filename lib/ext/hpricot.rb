module Hpricot
  module Traverse
    def insert_js(position, name)
      send(position, %(<script src="/#{name}"> </script>))
    end
  end
end