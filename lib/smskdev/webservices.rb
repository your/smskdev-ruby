require 'json'

module Smskdev
  class Webservices

    attr_reader :response

    include Sanitizer

    def initialize(username: nil, password: nil, token: nil, url: DEFAULT_URL)
      @url = url
      @u   = username
      @p   = password
      @h   = token

      if ((@h.nil? || @h.empty?) && (@u.nil? || @u.empty? || @p.nil? || @p.empty?))
        raise ArgumentError, 'Username and password or token required'
      end

      get_token(u: username, p: password) if token.nil? || token.empty?
    end

    def sms_queue_status(queue: nil)
      status(queue: queue)
    end

    def sms_delivery_status(smslog_id: nil)
      status(smslog_id: smslog_id).data[0]['status'] unless @response.nil? || @response.data.nil?
    end

    OPERATIONS.each do |operation|
      define_method("#{operation[0].to_s}") do |args|
        _validate_args(args, operation[1])
        _pack_request(args, operation[0])
      end
    end

    def sms_sent
      @response.nil? || @response.data.nil? ? [] : @response.data
    end

    def sms_succeded
      @response.nil? || @response.data.nil? ? [] : @response.data.select { |sms| sms['status'] == 'OK' }
    end

    def sms_failed
      @response.nil? || @response.data.nil? ? [] : @response.data.select { |sms| sms['status'] != 'OK' }
    end

    private

    def _pack_request(args, op = nil)
      params = args.keys.map do |arg_key|
        [arg_key, send("sanitize_#{arg_key}".to_sym, args[arg_key])].join('=')
      end.join('&')
      url = _compose_url(_op_params(OPERATIONS[op][:op]), params)
      _get_response(url)
    end

    def _validate_args(args, op = nil)
      raise ArgumentError unless !op.nil?
    	unless !args.nil? && !args.empty? && op.is_a?(Hash) &&
    	  !op[:mandatory].map{ |mandatory_param| args[mandatory_param.to_sym] }.include?(nil)
    	  raise ArgumentError
    	end
    end

    def _get_response(url)
      @response = Response.new(json_response: Connector.get(url))
      @h = @response.token unless @response.token.nil?
      @response
    end

    def _compose_url(op_params, additional_params)
    	[_base_params, op_params, additional_params].join('&')
    end

    def _auth_params
      ["u=#{@u}", "h=#{@h}"].join('&') unless @h.nil?
    end

    def _app_params
    	"app=ws"
    end

    def _op_params(op)
      "op=#{op.to_s}"
    end

    def _base_params
      auth_params = _auth_params

      unless auth_params.nil?
        [[_base_url, _app_params].join('?'), _auth_params].join('&')
      else
        [_base_url, _app_params].join('?')
      end
    end

    def _base_url
    	@url
    end
  end

  # TODO: move this to a standalone file.
  class Response
    attr_reader :status, :error, :token, :data, :error_string, :timestamp

    def initialize(json_response: nil)
      unless json_response.nil? && json_response.empty?
        @status, @error, @token, @data, @error_string, @timestamp = _parse_response(json_response)
      else
        raise JsonError
      end
    end

    private

    def _parse_response(json_response)
      parsed_response = JSON.parse(json_response)

      [parsed_response['status'],
       parsed_response['error'],
       parsed_response['token'],
       parsed_response['data'],
       parsed_response['error_string'],
       parsed_response['timestamp']]
    end
  end
end