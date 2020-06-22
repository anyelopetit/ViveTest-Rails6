# frozen_string_literal: true

Redis.current =
  Redis.new(
    url: ENV['REDIS_URL'],
    port: 6379,
    db: 0
  )