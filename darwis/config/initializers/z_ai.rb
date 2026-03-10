begin
  require "dotenv/load"
  Dotenv.load
rescue LoadError => e
  warn "Warning: Could not load dotenv gem: #{e.message}"
end

begin
  require "z/ai"
rescue LoadError => e
  warn "Warning: Could not load Z.ai SDK: #{e.message}. Run: bundle install"
end

if defined?(Z::AI)
  Z::AI.configure do |config|
    config.api_key = ENV.fetch("ZAI_API_KEY") do
      raise "ZAI_API_KEY environment variable is not set"
    end
    config.base_url = ENV["ZAI_BASE_URL"] || "https://api.z.ai/api/paas/v4/"
    config.timeout = ENV["ZAI_TIMEOUT"]&.to_i || 30
    config.default_model = "glm-5"
  end
end
