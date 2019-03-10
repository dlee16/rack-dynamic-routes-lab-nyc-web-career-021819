require_relative 'item'

class Application
  @@items = []
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    # if req.path=="/items/"
    if req.path.match(/items/)
      items = req.path.split("/items/").last
      if item_name = @@items.find {|i| i.name == items}
        resp.write item_name.price
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end
end
