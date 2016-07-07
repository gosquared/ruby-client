require 'net/https'
require 'uri'
require 'json'

describe Client do
	subject(:client) { described_class.new }

	EXCEPTIONS = [Timeout::Error, EOFError,
			Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError]

EXCEPTIONS.each do |exception|	
	it 'raises a #{exception} error' do
		uri = URI('www.example.com')
		allow(Net::HTTP).to receive(:get).with(uri).and_raise(exception)
		expect{client.get('www.example.com')}.to output("[error] HTTP error: #{exception}\n[error] StandardError: Could not parse JSON\n").to_stdout
	end 
end

it 'raises a Errno::EINVAL error' do
		uri = URI('www.example.com')
		allow(Net::HTTP).to receive(:get).with(uri).and_raise(Errno::EINVAL)
		expect{client.get('www.example.com')}.to output("[error] HTTP error: Invalid argument\n[error] StandardError: Could not parse JSON\n").to_stdout
	end 

it 'raises a Errno::ECONNRESET error' do
		uri = URI('www.example.com')
		allow(Net::HTTP).to receive(:get).with(uri).and_raise(Errno::ECONNRESET)
		expect{client.get('www.example.com')}.to output("[error] HTTP error: Connection reset by peer\n[error] StandardError: Could not parse JSON\n").to_stdout
	end 

end