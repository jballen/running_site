json.array!(@runs) do |run|
  json.extract! run, :user_id, :distance, :duration
  json.url run_url(run, format: :json)
end