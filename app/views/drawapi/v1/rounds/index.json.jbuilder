json.rounds do
    json.array! @rounds do |round|
        json.extract! round, :id, :created_at
        
        # 将时间转换为北京时间  
        beijing_time = round.created_at.in_time_zone('Asia/Shanghai')  
                
        # 调整时间格式为 'YYYY-MM-DD HH:MM:SS'  
        formatted_time = beijing_time.strftime('%Y-%m-%d %H:%M:%S')  
        
        json.created_at formatted_time
    end
end