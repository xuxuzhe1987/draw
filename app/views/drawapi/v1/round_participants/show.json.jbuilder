json.extract! @participant, :id, :name, :company, :created_at

# Convert time to Beijing time
beijing_time = @participant[:created_at].in_time_zone('Asia/Shanghai')

# Adjust time format to 'YYYY-MM-DD HH:MM:SS'
formatted_time = beijing_time.strftime('%Y-%m-%d %H:%M:%S')

# Add the adjusted time to JSON
json.created_at formatted_time