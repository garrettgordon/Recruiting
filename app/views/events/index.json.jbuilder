json.array!(@events) do |event|
  json.extract! event, :id, :name, :location, :eventdate, :description, :link
  json.url event_url(event, format: :json)
end
