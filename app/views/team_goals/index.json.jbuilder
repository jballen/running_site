json.array!(@team_goals) do |team_goal|
  json.extract! team_goal, :team_id, :start_date, :end_date, :distance, :duration, :activity, :title
  json.url team_goal_url(team_goal, format: :json)
end