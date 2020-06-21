# frozen_string_literal: true

Redis.current =
  Redis.new(
    url: 'redis://h:p5c369ad565e26b27c191da28aae07652f3f4707953bd2fbe667dfb5ce051e2d3@ec2-54-167-234-190.compute-1.amazonaws.com:13229',
    port: ENV['REDIS_PORT'],
    db: ENV['REDIS_DB']
  )