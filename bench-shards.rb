require 'typhoeus'
require 'concurrent'

hydra = Typhoeus::Hydra.new

PREFIX = 'https://pods-cdn.me'
# PREFIX = 'http://localhost:3000'

counters = {}
shard_components = '0123456789abcdef'.scan(/\w/)
triples = shard_components.product(shard_components, shard_components).shuffle

triples.each do |triple|
  request = Typhoeus::Request.new("#{PREFIX}/all_pods_versions_#{triple.join('_')}.txt", 
                                  method: :get,         
                                  http_version: :httpv2_0,
                                  accept_encoding: 'gzip'
                                  )
  request.on_complete do |response|
    # STDERR.puts "#{a} #{b} #{c}: #{response.code}"
    counters[response.code] = (counters[response.code] || 0) + 1
    # require 'pry'; binding.pry if response.code == 0
  end
  hydra.queue(request)
end

hydra.run

STDERR.puts counters