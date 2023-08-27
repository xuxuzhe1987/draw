# Extract data from JSON
json.extract! @round, :id, :num, :created_at
# Convert time to Beijing time
beijing_time = @round[:created_at].in_time_zone('Asia/Shanghai')

# Adjust time format to 'YYYY-MM-DD HH:MM:SS'
formatted_time = beijing_time.strftime('%Y-%m-%d %H:%M:%S')

# Add the adjusted time to JSON
json.created_at formatted_time

json.participants @participants do |participant|
    json.extract! participant, :id, :name, :company, :result, :created_at
end

