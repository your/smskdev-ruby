require 'spec_helper'
require 'smskdev'

describe Smskdev do
  describe "#initialize" do
    context "with wrong arguments" do
      it "should raise ArgumentError if no arguments passed" do
        expect{ Smskdev::Webservices.new }.to raise_error(ArgumentError)
      end

      it "should raise ArgumentError if no username passed" do
        expect{ Smskdev::Webservices.new(username: nil) }.to raise_error(ArgumentError)
        expect{ Smskdev::Webservices.new(username: '') }.to raise_error(ArgumentError)
      end

      it "should raise ArgumentError if no password passed" do
        expect{ Smskdev::Webservices.new(password: nil) }.to raise_error(ArgumentError)
        expect{ Smskdev::Webservices.new(password: '') }.to raise_error(ArgumentError)
      end

      it "should raise ArgumentError if no username and/or password or token passed" do
        expect{ Smskdev::Webservices.new(username: nil, password: nil) }.to raise_error(ArgumentError)
        expect{ Smskdev::Webservices.new(username: '', password: '') }.to raise_error(ArgumentError)
        expect{ Smskdev::Webservices.new(username: nil, password: '') }.to raise_error(ArgumentError)
        expect{ Smskdev::Webservices.new(username: '', password: nil) }.to raise_error(ArgumentError)
        expect{ Smskdev::Webservices.new(username: 'whatever', password: nil) }.to raise_error(ArgumentError)
        expect{ Smskdev::Webservices.new(username: 'whatever', password: '') }.to raise_error(ArgumentError)
        expect{ Smskdev::Webservices.new(username: nil, password: 'whatever') }.to raise_error(ArgumentError)
        expect{ Smskdev::Webservices.new(username: '', password: 'whatever') }.to raise_error(ArgumentError)
        expect{ Smskdev::Webservices.new(username: nil, password: nil, token: nil) }.to raise_error(ArgumentError)
        expect{ Smskdev::Webservices.new(username: nil, password: nil, token: '') }.to raise_error(ArgumentError)
        expect{ Smskdev::Webservices.new(username: '', password: nil, token: nil) }.to raise_error(ArgumentError)
        expect{ Smskdev::Webservices.new(username: 'whatever', password: nil, token: nil) }.to raise_error(ArgumentError)
        expect{ Smskdev::Webservices.new(username: '', password: 'whatever', token: nil) }.to raise_error(ArgumentError)
        expect{ Smskdev::Webservices.new(username: nil, password: 'whatever', token: nil) }.to raise_error(ArgumentError)
        expect{ Smskdev::Webservices.new(username: '', password: '', token: nil) }.to raise_error(ArgumentError)
        expect{ Smskdev::Webservices.new(username: '', password: '', token: '') }.to raise_error(ArgumentError)
      end

      it "should not raise errors if token and/or username with password provided" do
        expect{ Smskdev::Webservices.new(username: nil, password: nil, token: 'whatever') }.not_to raise_error
        expect{ Smskdev::Webservices.new(username: '', password: '', token: 'TOKEN') }.not_to raise_error
        expect{ Smskdev::Webservices.new(username: 'whatever', password: 'whatever', token: 'TOKEN') }.not_to raise_error
        expect{ Smskdev::Webservices.new(username: 'whatever', password: 'whatever', token: '') }.not_to raise_error
      end

      it "should remotely get a token if not passed" do
        allow(Smskdev::Webservices.new(username: 'test', password: 'test', token: nil)).to receive(:get_token)
      end
    end
  end

  describe "#get_token", :pending => true do
  end

  describe "#send_sms", :pending => true do
  end

  describe "#status", :pending => true do
  end
end
