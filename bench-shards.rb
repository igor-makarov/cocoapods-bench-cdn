require 'typhoeus'
require 'concurrent'
require 'benchmark'

hydra = Typhoeus::Hydra.new

PREFIX = 'https://pods-cdn.me'
# PREFIX = 'http://localhost:3000'

shard_components = '0123456789abcdef'.scan(/\w/)
triples = shard_components.product(shard_components, shard_components)

def request(url)
  request = Typhoeus::Request.new("#{PREFIX}#{url}", 
                                      method: :get,         
                                      http_version: :httpv2_0,
                                      accept_encoding: 'gzip'
                                      )
end

# 50.times.each do
loop do
  counters = {}

  time = Benchmark.measure do
    urls = #['/all_pods.txt'] + 
      triples.shuffle.map { |t| "/all_pods_versions_#{t.join('_')}.txt"}
    urls.each do |url|
      request = request(url)
      request.on_complete do |response|
        # STDERR.puts "#{url}: #{response.code}"
        # STDERR.puts "#{triple}: #{response.headers['cache-control']}"
        counters[response.code] = (counters[response.code] || 0) + 1
        # require 'pry'; binding.pry if response.code == 0
      end
      # request.run
      hydra.queue(request)
    end
  
    hydra.run
  end
  STDERR.puts counters
  STDERR.puts "#{1000 * time.real / triples.length}ms per req in parallel (#{triples.length} shards)"
end
