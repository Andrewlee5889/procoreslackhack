require "rest-client"
require "omniauth-procore"

module Procore
  class Client
    def self.get(endpoint:)
      new(endpoint).get
    end

    def self.patch(endpoint:, data:)
      new(endpoint, data).patch
    end

    def self.post(endpoint:, data:)
      new(endpoint, data).post
    end

    def initialize(endpoint, data={})
      @endpoint = endpoint
      @data = data
    end

    def get
      begin
        RestClient::Request.execute(method: :get, url: vapid_url, headers: headers, timeout: 120)
      rescue RestClient::ExceptionWithResponse => e
        e.response
      end
    end

    def patch
      begin
        RestClient::Request.execute(method: :patch, url: vapid_url, payload: data, headers: headers, timeout: 120)
      rescue RestClient::ExceptionWithResponse => e
        e.response
      end
    end

    def post
      begin
        RestClient::Request.execute(method: :post, url: vapid_url, payload: data, headers: headers, timeout: 120)
      rescue RestClient::ExceptionWithResponse => e
        e.response
      end
    end

    private
    attr_reader :endpoint, :data

    def vapid_url
      "#{PROCORE_ROOT}/vapid/#{endpoint}"
    end

    def headers
      {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{access_token}"
      }
    end

    def access_token
      # TODO: get access_token using OmniAuth
    end
  end
end
