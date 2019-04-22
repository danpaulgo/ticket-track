json.extract! transaction_source, :id, :created_at, :updated_at
json.url transaction_source_url(transaction_source, format: :json)
