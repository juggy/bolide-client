require 'nokogiri'

module Bolide

  class Q
    attr_accessor :token, :name, :bolide, :expire_on, :msg_count
    
    def initialize(bolide, name)
      @bolide = bolide
      @name = name
      @token = nil
      @expire_on = nil
      @msg_count = nil
    end
    
    def expired?
      resp = bolide.session.get('/q/' + name + '.xml', bolide.headers)
      if resp.status < 400
        read_response resp
      else
        raise read_error(resp)
      end
      @expire_on && @expire_on > DateTime.now && @token
    end
    
    def new_token
      resp = bolide.session.put('/q/' + name + '.xml','', bolide.headers)
      if resp.status < 400
        read_response resp
      else 
        raise read_error(resp)
      end
      return @token
    end
    
    def send_msg(body)
      bolide.send_msg(body,  [@name])
    end
    
    def marshal_dump
      {
        :name=>@name,
        :token=>@token,
        :bolide=>@bolide,
        :msg_count=>@msg_count,
        :expire_on=>@expire_on
      }
    end

    def marshal_load(data)
      @name = data[:name]
      @bolide = data[:bolide]
      @msg_count = data[:msg_count]
      @token = data[:token]
      @expire_on = data[:expire_on]
    end
    
  private
    def read_error(resp)
      xml = Nokogiri::XML(resp.body)

      @error = xml.at_css('error').content
      if(@error)
        p @error
        @error
      end
    end
  
    def read_response(resp)
      #parse xml
      xml = Nokogiri::XML(resp.body)
      
      @token = xml.at_css('q token').content
      @expire_on = xml.at_css('q expire_on').content
      @msg_count = xml.at_css('q msg_count').content
    end
  end
end