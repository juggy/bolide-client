require 'patron'
require 'nokogiri'
require 'digest/md5'

module Bolide

  class Account 
    attr_accessor :session, :account
  
    def initialize(account, api_key, url = 'http://live.bolideapp.com')
      @account = account
      @api_key = api_key
      @url = url
      @session = Patron::Session.new
      @session.base_url = @url
    end

    def get_q(name, create = true)
      q = Q.new(self , name)
      q.new_token if create
      q 
    end
  
    def send_msg(body, qs = ".*")
      return false if !qs.kind_of?(String) && !qs.kind_of?(Array)
    
      msg = create_msg(body, qs)
      resp = session.post('/msg.xml', msg, headers)
      p resp.body
      if resp.status > 400
        xml = Nokogiri::XML(resp.body)

        @error = xml.at_css('error')
        if(@error)
          raise @error.content
        else
          raise resp.body
        end
      end
    end
  
    def headers
      now = DateTime.now.to_s
      return {'X-Bol-Date'=>now, 'X-Bol-Authentication'=>auth_key(now), 'Content-Type'=>'application/xml'}
    end
    
    def marshal_dump
      {
        :account=>@account,
        :api_key=>@api_key,
        :url=>@url,
      }
    end

    def marshal_load(data)
      @account = data[:account]
      @api_key = data[:api_key]
      @url = data[:url]
      @session = Patron::Session.new
      @session.base_url = @url
    end

  private
    def auth_key(now)
      auth_key_prev = 'Account:' + @account + '\n' + 'Api-Key:' + @api_key + '\n' + 'X-Bol-Date:' + now
      auth_key = Digest::MD5.hexdigest(auth_key_prev)
      @account + ':' + auth_key
    end
  
    def create_msg(body, qs)
      xml = Nokogiri::XML::Builder.new do |xml|
        xml.msg do
          if qs.kind_of?(String)
            xml.qs :select=>qs
          elsif qs.kind_of?(Array)
            xml.qs do
              qs.each do |q|
                if q.kind_of?(Bolide::Q)
                  xml.q q.name 
                else
                  xml.q q
                end
              end
            end
          end
          xml.body do
            xml.cdata body
          end
        end
      end
      xml.to_xml.to_s
    end
  
  end
end