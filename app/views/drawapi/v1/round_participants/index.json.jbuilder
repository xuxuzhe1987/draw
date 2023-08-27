json.participants do
    json.array! @participants do |participant|
        json.extract! participant, :id, :name, :company
    end
end