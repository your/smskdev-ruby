require 'spec_helper'
require 'vcr_helper'
require 'smskdev'

describe Smskdev do
  describe "#initialize" do
    context "with wrong arguments" do
      it "should raise ArgumentError if no arguments passed" do
        expect{ Smskdev::Webservices.new }.to raise_error(ArgumentError)
      end

      it "should raise ArgumentError if no username passed" do
        expect{ Smskdev::Webservices.new(username: nil) }.to raise_error(ArgumentError)
      end

      it "should raise ArgumentError if no password passed" do
        expect{ Smskdev::Webservices.new(password: nil) }.to raise_error(ArgumentError)
      end

      it "should raise ArgumentError if no username and/or password or token passed" do
        expect{ Smskdev::Webservices.new(username: nil, password: nil) }.to raise_error(ArgumentError)
        expect{ Smskdev::Webservices.new(username: 'whatever', password: nil) }.to raise_error(ArgumentError)
        expect{ Smskdev::Webservices.new(username: nil, password: 'whatever') }.to raise_error(ArgumentError)
        expect{ Smskdev::Webservices.new(username: nil, password: nil, token: nil) }.to raise_error(ArgumentError)
        expect{ Smskdev::Webservices.new(username: 'whatever', password: nil, token: nil) }.to raise_error(ArgumentError)
        expect{ Smskdev::Webservices.new(username: nil, password: 'whatever', token: nil) }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#get_token" do
    context "with valid credentials" do
      before do
        VCR.use_cassette("get_token_failure") do
          @s = Smskdev::Webservices.new(username: 'INVALID_USER', password: 'INVALID_PASS')
        end
      end

      it { expect(@s.response.status).to eq("ERR") }
      it { expect(@s.response.error).to eq("100") }
      it { expect(@s.response.error_string).to eq("authentication failed") }
      it { expect(@s.response.token).to be_nil }
    end

    context "with valid credentials" do
      before do
        VCR.use_cassette("get_token_success") do
          @s = Smskdev::Webservices.new(username: 'VALID_USER', password: 'VALID_PASS')
        end
      end

      it { expect(@s.response.status).to eq("OK") }
      it { expect(@s.response.error).to eq("0") }
      it { expect(@s.response.error_string).to be_nil }
      it { expect(@s.response.token).not_to be_nil }
    end
  end

  describe "#send_sms" do
    before do
      VCR.use_cassette("send_sms") do
        @s = Smskdev::Webservices.new(username: 'VALID_USER', token: 'VALID_TOKEN')
        @s.send_sms(to: '+393271010101', msg: 'Test message', type: 'text', unicode: true)
      end
    end

    it { expect(@s.response.status).to be_nil }
    it { expect(@s.response.error).to be_nil }
    it { expect(@s.response.error_string).to be_nil }

    it { expect(@s.response.data[0]['status']).to eq "OK" }
    it { expect(@s.response.data[0]['error']).to eq "0" }
    it { expect(@s.response.data[0]['smslog_id']).to eq "1770487" }
    it { expect(@s.response.data[0]['queue']).to eq "c7ab86c37afe12889fefb060cfb59d33" }
    it { expect(@s.response.data[0]['to']).to eq "393271010101" }
  end

  describe "#status" do
    before do
      VCR.use_cassette("status") do
        @s = Smskdev::Webservices.new(username: 'VALID_USER', token: 'VALID_TOKEN')
        @s.status(smslog_id: 1770487)
      end
    end

    it { expect(@s.response.status).to be_nil }
    it { expect(@s.response.error).to be_nil }
    it { expect(@s.response.error_string).to be_nil }

    it { expect(@s.response.data[0]['smslog_id']).to eq "1770487" }
    it { expect(@s.response.data[0]['src']).to eq "God" }
    it { expect(@s.response.data[0]['dst']).to eq "393271010101" }
    it { expect(@s.response.data[0]['msg']).to eq "Test message" }
    it { expect(@s.response.data[0]['status']).to eq "0" }
  end
end
