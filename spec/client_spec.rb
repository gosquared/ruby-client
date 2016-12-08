require 'net/https'
require 'uri'
require 'json'

describe Gosquared::Client do
	subject(:client) { described_class.new }

	EXCEPTIONS = [Timeout::Error, EOFError,
			Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError]

EXCEPTIONS.each do |exception|
	it "raises a #{exception} error on a get request" do
		uri = URI('www.example.com')
		allow(Net::HTTP).to receive(:get).with(uri).and_raise(exception)
		expect{client.get('www.example.com')}.to output("[error] HTTP error: #{exception}\n[error] StandardError: Could not parse JSON\n").to_stdout
	end
end

it "raises a Errno::EINVAL error on a get request" do
		uri = URI('www.example.com')
		allow(Net::HTTP).to receive(:get).with(uri).and_raise(Errno::EINVAL)
		expect{client.get('www.example.com')}.to output("[error] HTTP error: Invalid argument\n[error] StandardError: Could not parse JSON\n").to_stdout
	end

it "raises a Errno::ECONNRESET error on a get request" do
		uri = URI('www.example.com')
		allow(Net::HTTP).to receive(:get).with(uri).and_raise(Errno::ECONNRESET)
		expect{client.get('www.example.com')}.to output("[error] HTTP error: Connection reset by peer\n[error] StandardError: Could not parse JSON\n").to_stdout
	end

EXCEPTIONS.each do |exception|
	it "raises a #{exception} error on a post request" do
		uri = URI.parse("www.example.com")
		allow(Net::HTTP).to receive(:new).with(uri.host, uri.port).and_raise(exception)
		expect{client.post("www.example.com", "body")}.to output("[error] HTTP error: #{exception}\n[error] StandardError: Could not print response message\n").to_stdout
	end
end

it "raises a Errno::EINVAL error on a post request" do
		uri = URI.parse("www.example.com")
		allow(Net::HTTP).to receive(:new).with(uri.host, uri.port).and_raise(Errno::EINVAL)
		expect{client.post("www.example.com", "body")}.to output("[error] HTTP error: Invalid argument\n[error] StandardError: Could not print response message\n").to_stdout
	end

it "raises a Errno::ECONNRESET error on a post request" do
		uri = URI.parse("www.example.com")
		allow(Net::HTTP).to receive(:new).with(uri.host, uri.port).and_raise(Errno::ECONNRESET)
		expect{client.post("www.example.com", "body")}.to output("[error] HTTP error: Connection reset by peer\n[error] StandardError: Could not print response message\n").to_stdout
	end

EXCEPTIONS.each do |exception|
	it "raises a #{exception} error on a delete request" do
		uri = URI.parse("www.example.com")
		allow(Net::HTTP).to receive(:new).with(uri.host, uri.port).and_raise(exception)
		expect{client.delete("www.example.com", "body")}.to output("[error] HTTP error: #{exception}\n[error] StandardError: Could not print response message\n").to_stdout
	end
end

it "raises a Errno::EINVAL error on a delete request" do
		uri = URI.parse("www.example.com")
		allow(Net::HTTP).to receive(:new).with(uri.host, uri.port).and_raise(Errno::EINVAL)
		expect{client.delete("www.example.com", "body")}.to output("[error] HTTP error: Invalid argument\n[error] StandardError: Could not print response message\n").to_stdout
	end

it "raises a Errno::ECONNRESET error on a delete request" do
		uri = URI.parse("www.example.com")
		allow(Net::HTTP).to receive(:new).with(uri.host, uri.port).and_raise(Errno::ECONNRESET)
		expect{client.delete("www.example.com", "body")}.to output("[error] HTTP error: Connection reset by peer\n[error] StandardError: Could not print response message\n").to_stdout
	end

end
