class App
  route do |r|
    r.root do
      r.get do
        render 'index'
      end
    end
  end
end
